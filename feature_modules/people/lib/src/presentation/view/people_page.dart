import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/people_page_loading.dart';
import '../component/people_suggestion_tile.dart';
import '../viewmodel/people_page_driver.dart';

class PeoplePage extends DrivableWidget<PeoplePageDriver> {
  PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: "People",
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: LmuPageAnimationWrapper(
          child: Align(
            //key: ValueKey("people_page_${driver.isLoading}"),
            alignment: Alignment.topCenter,
            child: content,
          ),
        ),
      ),
    );
  }

  Widget get content {
    if (driver.isLoading) return const PeoplePageLoading(); // replace with skeleton loading

    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_16),
        LmuContentTile(
          content: LmuListItem.action(
            title: driver.allPeopleTitle,
            trailingTitle: driver.allPeopleCount,
            actionType: LmuListItemAction.chevron,
            onTap: driver.onAllPeoplePressed,
          ),
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuTileHeadline.base(title: "Faultiere"),
        LmuContentTile(
          contentList: driver.peopleCategories
              .mapIndexed(
                (index, people) => LmuListItem.action(
                  key: Key("people_category_${people.hashCode}"),
                  title: people.name,
                  subtitle: people.description,
                  leadingArea: LmuInListBlurEmoji(emoji: people.emoji),
                  trailingTitle: people.peoples.length.toString(),
                  hasDivider: index != driver.peopleCategories.length - 1,
                  actionType: LmuListItemAction.chevron,
                  onTap: () => driver.onPeopleCardPressed(),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: LmuSizes.size_32),
        const PeopleSuggestionTile(),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  @override
  WidgetDriverProvider<PeoplePageDriver> get driverProvider => $PeoplePageDriverProvider();
}
