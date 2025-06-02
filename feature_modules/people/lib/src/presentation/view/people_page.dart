import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/people_card.dart';
import '../viewmodel/people_page_driver.dart';

class PeoplePage extends DrivableWidget<PeoplePageDriver> {
  PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: LmuPageAnimationWrapper(
          child: Align(
            key: ValueKey("people_page_${driver.isLoading}"),
            alignment: Alignment.topCenter,
            child: content(context),
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    if (driver.isLoading) return const SizedBox.shrink(); // replace with skeleton loading

    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_16),
        LmuTileHeadline.base(title: "Faculty 1: Mathematics and Statictics"),
        PeopleCard(
          id: driver.peopleId,
          title: driver.title,
          description: driver.description,
          hasFavoriteStar: driver.favoriteStates[0],
          onTap: () => driver.onPeopleCardPressed(context, driver.peopleId, driver.title, driver.description),
          onFavoriteTap: () => driver.toggleFavorite(0), // <--- Stern-Klick
        ),
        const SizedBox(height: LmuSizes.size_16),
        PeopleCard(
          id: driver.peopleId,
          title: driver.title,
          description: driver.description,
          onTap: () => driver.onPeopleCardPressed(context, driver.peopleId, driver.title, driver.description),
          hasFavoriteStar: true,
          onFavoriteTap: () => driver.toggleFavorite(1),
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuTileHeadline.base(title: "Faculty 2: Chemistry"),
        PeopleCard(
          id: driver.peopleId,
          title: driver.title,
          description: driver.description,
          onTap: () => driver.onPeopleCardPressed(context, driver.peopleId, driver.title, driver.description),
          hasFavoriteStar: true,
          onFavoriteTap: () => driver.toggleFavorite(0),
        ),
        const SizedBox(height: LmuSizes.size_16),
      ],
    );
  }

  @override
  WidgetDriverProvider<PeoplePageDriver> get driverProvider => $PeoplePageDriverProvider();
}
