import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/people_suggestion_tile.dart';
import '../viewmodel/all_people_page_driver.dart';
import './all_people_page_loading.dart';

class AllPeoplePage extends DrivableWidget<AllPeoplePageDriver> {
  AllPeoplePage({super.key});

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

    // Sort and group by initial letter (or "#" if none)
    final sortedPeoples = List.of(driver.peoples)..sort((a, b) => a.basicInfo.lastName.compareTo(b.basicInfo.lastName));
    final grouped = groupBy(
      sortedPeoples,
      (p) => p.basicInfo.lastName.isNotEmpty ? p.basicInfo.lastName[0].toUpperCase() : '#',
    );

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // one tile per letter
            for (final entry in grouped.entries) ...[
              LmuTileHeadline.base(title: entry.key),
              LmuContentTile(
                contentList: entry.value.asMap().entries.map((indexedPerson) {
                  final index = indexedPerson.key;
                  final people = indexedPerson.value;
                  final nameParts = [
                    people.basicInfo.lastName,
                    people.basicInfo.firstName,
                    if ((people.basicInfo.academicDegree?.isNotEmpty ?? false)) people.basicInfo.academicDegree!
                  ].where((s) => s.isNotEmpty).toList();

                  return LmuListItem.action(
                    key: Key('person_${people.id}_${entry.key}_$index'),
                    title: nameParts.join(' '),
                    subtitle: people.basicInfo.status,
                    hasDivider: true,
                    actionType: LmuListItemAction.chevron,
                    onTap: () => driver.onPeopleCardPressed(people.id),
                  );
                }).toList(),
              ),
              const SizedBox(height: LmuSizes.size_16),
            ],
            const PeopleSuggestionTile(),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<AllPeoplePageDriver> get driverProvider => $AllPeoplePageDriverProvider();
}
