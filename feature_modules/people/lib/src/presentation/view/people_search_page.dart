import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

import '../viewmodel/people_search_driver.dart';

class PeopleSearchPage extends DrivableWidget<PeopleSearchDriver> {
  PeopleSearchPage({super.key, required this.facultyId});

  final int facultyId;

  @override
  PeopleSearchDriver createDriver() => GetIt.I<PeopleSearchDriver>(param1: facultyId);

  @override
  Widget build(BuildContext context) {
    return _PeopleSearchPageCustom<PeopleSearchEntry>(
      searchEntries: driver.searchEntries,
      recentSearchEntries: driver.recentSearchEntries,
      recentSearchController: driver.recentSearchController,
      onRecentSearchesUpdated: (recentSearchEntries) => driver.updateRecentSearch(recentSearchEntries),

      searchEntryBuilder: (PeopleSearchEntry entry) {
        final person = entry.person;
        return LmuListItem.action(
          title: '${person.name} ${person.surname}',
          subtitle: person.title.isNotEmpty ? person.title : person.role,
          actionType: LmuListItemAction.chevron,
          onTap: () {
            driver.onPersonPressed(context, person);
            driver.recentSearchController.trigger(entry);
          },
        );
      },
    );
  }

  @override
  WidgetDriverProvider<PeopleSearchDriver> get driverProvider => $PeopleSearchDriverProvider(facultyId: facultyId);
}

class _PeopleSearchPageCustom<T extends SearchEntry> extends StatefulWidget {
  const _PeopleSearchPageCustom({
    required this.searchEntryBuilder,
    required this.searchEntries,
    this.recentSearchEntries,
    this.onRecentSearchesUpdated,

    this.maxRecentSearchEntries = 5,
    this.recentSearchController,
    this.searchCutoff = 60,
  });

  final Widget Function(T) searchEntryBuilder;
  final List<T> searchEntries;
  final List<T>? recentSearchEntries;
  final void Function(List<T>)? onRecentSearchesUpdated;

  final LmuRecentSearchController<T>? recentSearchController;
  final int maxRecentSearchEntries;
  final int searchCutoff;
  
  static const Duration animationDuration = Duration(milliseconds: 150);
  static const EdgeInsets searchPadding = EdgeInsets.symmetric(horizontal: LmuSizes.size_16);
  static const EdgeInsets contentPadding = EdgeInsets.only(top: LmuSizes.size_16, bottom: LmuSizes.size_96);

  @override
  State<_PeopleSearchPageCustom<T>> createState() => _PeopleSearchPageCustomState<T>();
}

class _PeopleSearchPageCustomState<T extends SearchEntry> extends State<_PeopleSearchPageCustom<T>> {
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
    return LmuScaffold(
      appBar: LmuAppBarData.custom(
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
      ),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Padding(
                padding: _PeopleSearchPageCustom.searchPadding,
                child: ValueListenableBuilder(
                  valueListenable: _isSearchActiveNotifier,
                  builder: (context, isSearchActive, _) {
                    return ValueListenableBuilder(
                      valueListenable: _searchEntriesNotifier,
                      builder: (context, searchEntries, child) {
                        return AnimatedSwitcher(
                          duration: _PeopleSearchPageCustom.animationDuration,
                          switchInCurve: Curves.easeInOut,
                          child: searchEntries.isEmpty && !isSearchActive
                              ? child!
                              : searchEntries.isEmpty
                                  ? const Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        key: Key("search_empty"),
                                        padding: EdgeInsetsGeometry.only(
                                          top: LmuSizes.size_12,
                                        ),
                                        child: LmuEmptyState(type: EmptyStateType.noSearchResults),
                                      ),
                                    )
                                  : Padding(
                                      padding: _PeopleSearchPageCustom.contentPadding,
                                      child: Column(
                                        key: const Key("search_entries"),
                                        children: [
                                          LmuContentTile(
                                            contentList:
                                                searchEntries.map((input) => widget.searchEntryBuilder(input)).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                        );
                      },
                      child: Padding(
                        padding: _PeopleSearchPageCustom.contentPadding,
                        child: Column(
                          key: const Key("recent_searches"),
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
