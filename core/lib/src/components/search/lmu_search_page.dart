import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

abstract class SearchEntry {
  const SearchEntry({required this.title, this.tags});
  final String title;

  final List<String>? tags;
}

class LmuRecentSearchController<T extends SearchEntry> {
  void Function(T searchEntry)? triggerAction;

  void trigger(T searchEntry) => triggerAction?.call(searchEntry);
}

class LmuSearchPage<T extends SearchEntry> extends StatefulWidget {
  const LmuSearchPage({
    super.key,
    required this.searchEntryBuilder,
    required this.searchEntries,
    this.recentSearchEntries,
    this.onRecentSearchesUpdated,
    this.maxRecentSearchEntries = 5,
    this.recentSearchController,
    this.emptySearchEntries,
    this.emptySearchEntriesTitle,
    this.searchCutoff = 60,
  });

  final Widget Function(T) searchEntryBuilder;
  final List<T> searchEntries;
  final List<T>? recentSearchEntries;
  final void Function(List<T>)? onRecentSearchesUpdated;
  final LmuRecentSearchController<T>? recentSearchController;
  final int maxRecentSearchEntries;
  final String? emptySearchEntriesTitle;
  final List<T>? emptySearchEntries;
  final int searchCutoff;

  @override
  State<LmuSearchPage<T>> createState() => _LmuSearchPageState<T>();
}

class _LmuSearchPageState<T extends SearchEntry> extends State<LmuSearchPage<T>> {
  late ValueNotifier<List<T>> _recentSearchEntriesNotifier;
  late ValueNotifier<List<T>> _searchEntriesNotifier;
  late ValueNotifier<bool> _isSearchActiveNotifier;

  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();

    if (widget.recentSearchController != null) {
      widget.recentSearchController!.triggerAction = _updateRecentSearchEntries;
    }

    _recentSearchEntriesNotifier = ValueNotifier(widget.recentSearchEntries ?? []);
    _searchEntriesNotifier = ValueNotifier([]);
    _isSearchActiveNotifier = ValueNotifier(false);

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    _searchFocusNode.requestFocus();
  }

  void _updateRecentSearchEntries(T input) {
    final recentSearchEntries = List<T>.from(_recentSearchEntriesNotifier.value);
    if (recentSearchEntries.map((e) => e.title).contains(input.title)) {
      recentSearchEntries.removeWhere((element) => element.title == input.title);
    }
    final updatedRecentSearchEntries = [input, ...recentSearchEntries];
    if (updatedRecentSearchEntries.length > widget.maxRecentSearchEntries) {
      updatedRecentSearchEntries.removeLast();
    }
    widget.onRecentSearchesUpdated?.call(updatedRecentSearchEntries);
    _recentSearchEntriesNotifier.value = updatedRecentSearchEntries;
  }

  @override
  void dispose() {
    _recentSearchEntriesNotifier.dispose();
    _searchEntriesNotifier.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<T>? get _emptySearchEntries => widget.emptySearchEntries;

  void _search(String searchQuery) {
    final list = extractAllSorted(
      query: searchQuery,
      choices: widget.searchEntries,
      getter: (obj) => obj.title,
      cutoff: widget.searchCutoff,
    );

    final results = list.map((e) => e.choice).toList();
    _searchEntriesNotifier.value = results;
  }

  @override
  Widget build(BuildContext context) {
    final appLocals = context.locals.app;
    return LmuMasterAppBar.custom(
      leadingAction: LeadingAction.back,
      customLargeTitleWidget: SizedBox(
        height: 40,
        child: LmuSearchInputField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          onClearPressed: () {
            _isSearchActiveNotifier.value = false;
            _searchEntriesNotifier.value = [];
          },
          onChanged: (searchQuery) {
            _isSearchActiveNotifier.value = searchQuery.isNotEmpty;
            _search(searchQuery);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: ValueListenableBuilder(
                valueListenable: _isSearchActiveNotifier,
                builder: (context, isSearchActive, _) {
                  return ValueListenableBuilder(
                    valueListenable: _searchEntriesNotifier,
                    builder: (context, searchEntries, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        switchInCurve: Curves.easeInOut,
                        child: searchEntries.isEmpty && !isSearchActive
                            ? child!
                            : searchEntries.isEmpty
                                ? LmuIssueType(
                                    key: const Key("search_empty"), message: appLocals.noResults, hasSpacing: false)
                                : ListView(
                                    key: const Key("search_entries"),
                                    padding: const EdgeInsets.only(top: LmuSizes.size_16, bottom: LmuSizes.size_96),
                                    children: [
                                      LmuContentTile(
                                        contentList:
                                            searchEntries.map((input) => widget.searchEntryBuilder(input)).toList(),
                                      ),
                                    ],
                                  ),
                      );
                    },
                    child: ListView(
                      key: const Key("recent_searches"),
                      padding: const EdgeInsets.only(top: LmuSizes.size_16, bottom: LmuSizes.size_96),
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _recentSearchEntriesNotifier,
                          builder: (context, recentSearchEntries, child) {
                            if (recentSearchEntries.isEmpty) return const SizedBox.shrink();
                            return Column(
                              children: [
                                LmuTileHeadline.action(
                                  title: appLocals.prevSearch,
                                  actionTitle: appLocals.clear,
                                  onActionTap: () {
                                    widget.onRecentSearchesUpdated?.call([]);
                                    _recentSearchEntriesNotifier.value = [];
                                  },
                                ),
                                LmuContentTile(
                                  contentList: recentSearchEntries
                                      .map(
                                        (input) => widget.searchEntryBuilder(input),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: LmuSizes.size_32),
                              ],
                            );
                          },
                        ),
                        if (_emptySearchEntries != null && _emptySearchEntries!.isNotEmpty)
                          Column(
                            children: [
                              LmuTileHeadline.base(title: widget.emptySearchEntriesTitle!),
                              LmuContentTile(
                                contentList:
                                    _emptySearchEntries!.map((input) => widget.searchEntryBuilder(input)).toList(),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
