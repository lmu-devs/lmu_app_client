import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

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
            LmuTileHeadline.base(title: "Faultiere"),
            LmuContentTile(
              contentList: driver.peoples
                  .map(
                    (people) => LmuListItem.action(
                      key: Key("all_people_list_item_${people.hashCode}"),
                      title: people.name,
                      subtitle: people.description,
                      //leadingArea: LmuInListBlurEmoji(emoji: people.emoji),
                      actionType: LmuListItemAction.chevron,
                      onTap: () => driver.onPeopleCardPressed(people),
                    ),
                  )
                  .toList(),
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
