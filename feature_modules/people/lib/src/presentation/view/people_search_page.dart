import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

import '../viewmodel/people_search_driver.dart';

class PeopleSearchPage extends StatefulWidget {
  PeopleSearchPage({super.key, required this.facultyId});

  final int facultyId;

  @override
  State<PeopleSearchPage> createState() => _PeopleSearchPageState();
}

class _PeopleSearchPageState extends State<PeopleSearchPage> {
  late PeopleSearchDriver _driver;
  late ValueNotifier<List<PeopleSearchEntry>> _recentSearchEntriesNotifier;
  late ValueNotifier<List<PeopleSearchEntry>> _searchEntriesNotifier;
  late ValueNotifier<bool> _isSearchActiveNotifier;

  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();

    _driver = PeopleSearchDriver(facultyId: widget.facultyId);

    if (_driver.recentSearchController != null) {
      _driver.recentSearchController!.triggerAction = _updateRecentSearchEntries;
    }

    _recentSearchEntriesNotifier = ValueNotifier(_driver.recentSearchEntries);
    _searchEntriesNotifier = ValueNotifier([]);
    _isSearchActiveNotifier = ValueNotifier(false);

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    _searchFocusNode.requestFocus();
  }

  void _updateRecentSearchEntries(PeopleSearchEntry input) {
    final recentSearchEntries = List<PeopleSearchEntry>.from(_recentSearchEntriesNotifier.value);
    if (recentSearchEntries.map((e) => e.title).contains(input.title)) {
      recentSearchEntries.removeWhere((element) => element.title == input.title);
    }
    final updatedRecentSearchEntries = [input, ...recentSearchEntries];
    if (updatedRecentSearchEntries.length > 5) { // maxRecentSearchEntries = 5
      updatedRecentSearchEntries.removeLast();
    }
    _driver.updateRecentSearch(updatedRecentSearchEntries);
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
      choices: _driver.searchEntries,
      getter: (obj) => obj.title,
      cutoff: 60, // searchCutoff = 60
    );

    final results = list.map((e) => e.choice).toList();
    _searchEntriesNotifier.value = results;
  }

  Widget _buildSearchEntry(PeopleSearchEntry entry) {
    final person = entry.person;
    return LmuListItem.action(
      title: '${person.name} ${person.surname}',
      subtitle: person.title.isNotEmpty ? person.title : person.role,
      actionType: LmuListItemAction.chevron,
      onTap: () {
        _driver.onPersonPressed(context, person);
        _driver.recentSearchController.trigger(entry);
      },
    );
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
                                      padding: const EdgeInsets.only(top: LmuSizes.size_16, bottom: LmuSizes.size_96),
                                      child: Column(
                                        key: const Key("search_entries"),
                                        children: [
                                          LmuContentTile(
                                            contentList:
                                                searchEntries.map((input) => _buildSearchEntry(input)).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: LmuSizes.size_16, bottom: LmuSizes.size_96),
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
                                        _driver.updateRecentSearch([]);
                                        _recentSearchEntriesNotifier.value = [];
                                      },
                                    ),
                                    LmuContentTile(
                                      contentList: recentSearchEntries
                                          .map(
                                            (input) => _buildSearchEntry(input),
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
