import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/models/club_category_type.dart';
import '../components/club_card.dart';
import '../components/clubs_page_loading.dart';
import '../components/clubs_suggestion_tile.dart';
import '../viewmodel/clubs_page_driver.dart';

class ClubsPage extends DrivableWidget<ClubsPageDriver> {
  ClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.clubs.clubsTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    if (driver.isLoading) {
      return const ClubsPageLoading(
        key: ValueKey("clubs_page_loading"),
      );
    }
    if (driver.isGenericError) {
      return LmuEmptyState(type: EmptyStateType.generic, onRetry: driver.onRetry);
    }
    if (driver.isNoNetworkError) {
      return LmuEmptyState(type: EmptyStateType.noInternet, onRetry: driver.onRetry);
    }

    return Column(
      key: const ValueKey("clubs_page_content"),
      children: [
        const SizedBox(height: LmuSizes.size_16),
        if (driver.featuredClub != null) ...[
          LmuTileHeadline.base(title: context.locals.clubs.becomePartOfApp),
          ClubCard(
              club: driver.featuredClub!, onTap: () => driver.onFeaturedClubPressed(context, driver.featuredClub!)),
          const SizedBox(height: LmuSizes.size_32),
        ],
        LmuContentTile(
          content: LmuListItem.action(
            title: driver.allClubsTitle,
            trailingTitle: driver.allClubsCount,
            actionType: LmuListItemAction.chevron,
            onTap: driver.onAllClubsPressed,
          ),
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuContentTile(
          contentList: driver.clubCategories
              .mapIndexed(
                (index, category) => LmuListItem.action(
                  key: Key("club_category_${category.hashCode}"),
                  title: category.type.localizedName(context.locals.clubs),
                  trailingTitle: category.clubs.length.toString(),
                  hasDivider: index != driver.clubCategories.length - 1,
                  leadingArea: LmuInListBlurEmoji(emoji: "🐱"),
                  actionType: LmuListItemAction.chevron,
                  onTap: () => driver.onClubCategoryPressed(category),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: LmuSizes.size_32),
        const ClubsSuggestionTile(),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  @override
  WidgetDriverProvider<ClubsPageDriver> get driverProvider => $ClubsPageDriverProvider();
}
