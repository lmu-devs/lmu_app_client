import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/models/club_category.dart';
import '../components/club_card.dart';
import '../viewmodel/clubs_details_page_driver.dart';

class ClubsDetailsPage extends DrivableWidget<ClubsDetailsPageDriver> {
  ClubsDetailsPage({super.key, required this.category});

  final ClubCategory? category;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.title,
        leadingAction: LeadingAction.back,
      ),
      body: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: LmuSizes.size_16,
          right: LmuSizes.size_16,
          top: LmuSizes.size_16,
          bottom: LmuSizes.size_96,
        ),
        separatorBuilder: (context, index) => const SizedBox(height: LmuSizes.size_12),
        itemCount: driver.clubs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final club = driver.clubs[index];
          return ClubCard(
            key: Key("club_card_${club.hashCode}"),
            club: club,
            onTap: () => driver.onClubPressed(context, club),
          );
        },
      ),
    );
  }

  @override
  WidgetDriverProvider<ClubsDetailsPageDriver> get driverProvider => $ClubsDetailsPageDriverProvider(
        selectedCategory: category,
      );
}
