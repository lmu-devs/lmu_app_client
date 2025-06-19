import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../services/people_state_service.dart';
import '../component/alphabet_scrollbar.dart';
import '../component/people_suggestion_tile.dart';
import '../viewmodel/all_people_page_driver.dart';
import './all_people_page_loading.dart';

class AllPeoplePage extends DrivableWidget<AllPeoplePageDriver> {
  AllPeoplePage({super.key});

  final Map<String, GlobalKey> _groupKeys = {};
  final ScrollController _scrollController = ScrollController();

  void _scrollToKey(String letter) {
    final key = _groupKeys[letter];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (driver.isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: driver.title,
          leadingAction: LeadingAction.back,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            LmuSizes.size_16,
            LmuSizes.size_16,
            LmuSizes.size_16,
            LmuSizes.size_96,
          ),
          child: const AllPeoplePageLoading(),
        ),
      );
    }

    final peopleStateService = GetIt.I.get<PeopleStateService>(instanceName: 'filter');
    peopleStateService.updatePeople(driver.peoples);

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.title,
        leadingAction: LeadingAction.back,
      ),
      showScrollbar: false,
      customScrollController: _scrollController,
      fixedOverlay: ValueListenableBuilder(
        valueListenable: peopleStateService.filteredGroupedPeopleNotifier,
        builder: (context, groupedPeople, _) {
          if (groupedPeople.isEmpty) {
            return const SizedBox.shrink();
          }
          return AlphabetScrollbar(
            letters: groupedPeople.keys.toList()..sort(),
            onLetterSelected: _scrollToKey,
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: peopleStateService.filteredGroupedPeopleNotifier,
        builder: (context, groupedPeople, _) {
          if (groupedPeople.isEmpty) {
            return LmuIssueType(
              message: context.locals.app.searchEmpty,
              hasSpacing: false,
            );
          }

          final groupEntries = groupedPeople.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

          for (final entry in groupEntries) {
            _groupKeys.putIfAbsent(entry.key, () => GlobalKey());
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(
              LmuSizes.size_16,
              0,
              LmuSizes.size_48,
              LmuSizes.size_96,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final entry in groupEntries) ...[
                  LmuTileHeadline.base(
                    key: _groupKeys[entry.key],
                    title: entry.key,
                  ),
                  LmuContentTile(
                    contentList: entry.value.asMap().entries.map((indexed) {
                      final people = indexed.value;
                      return LmuListItem.action(
                        key: Key('person_${people.id}_${entry.key}_${indexed.key}'),
                        title: [
                          people.basicInfo.firstName,
                          people.basicInfo.lastName,
                          if (people.basicInfo.academicDegree?.isNotEmpty ?? false) people.basicInfo.academicDegree!
                        ].where((s) => s.isNotEmpty).join(' '),
                        subtitle: people.roles.isNotEmpty ? people.roles.first.role : null,
                        hasDivider: false,
                        actionType: LmuListItemAction.chevron,
                        onTap: () => driver.onPeopleCardPressed(people),
                      );
                    }).toList(),
                  ),
                  if (entry.key != groupEntries.last.key) const SizedBox(height: LmuSizes.size_32),
                ],
                const PeopleSuggestionTile(),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  WidgetDriverProvider<AllPeoplePageDriver> get driverProvider => $AllPeoplePageDriverProvider();
}
