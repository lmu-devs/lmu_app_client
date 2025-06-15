import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/people_card.dart';
import '../component/people_suggestion_tile.dart';
import '../viewmodel/all_people_page_driver.dart';

class AllPeoplePage extends DrivableWidget<AllPeoplePageDriver> {
  AllPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.title,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: LmuSizes.size_16,
          right: LmuSizes.size_16,
          top: LmuSizes.size_16,
          bottom: LmuSizes.size_96,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deine Listeneinträge als Widgets
            ...driver.peoples.map(
              (peopleItem) => Padding(
                padding: const EdgeInsets.only(bottom: LmuSizes.size_12),
                child: PeopleCard(
                  key: Key("people_card_${peopleItem.hashCode}"),
                  people: peopleItem,
                ),
              ),
            ),
            const SizedBox(height: LmuSizes.size_32),
            const PeopleSuggestionTile(),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<AllPeoplePageDriver> get driverProvider => $AllPeoplePageDriverProvider();
}
