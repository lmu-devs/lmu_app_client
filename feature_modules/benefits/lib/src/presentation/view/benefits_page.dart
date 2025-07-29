import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../components/benefit_suggestion_tile.dart';
import '../components/benefits_page_loading.dart';
import '../viewmodel/benefits_page_driver.dart';

class BenefitsPage extends DrivableWidget<BenefitsPageDriver> {
  BenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.home.benefits,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: content,
      ),
    );
  }

  Widget get content {
    if (driver.isLoading) {
      return const BenefitsPageLoading(
        key: ValueKey("benefits_page_loading"),
      );
    }
    if (driver.isGenericError) {
      return LmuEmptyState(type: EmptyStateType.generic, onRetry: driver.onRetry);
    }
    if (driver.isNoNetworkError) {
      return LmuEmptyState(type: EmptyStateType.noInternet, onRetry: driver.onRetry);
    }

    return Column(
      key: ValueKey("benefits_page_content"),
      children: [
        const SizedBox(height: LmuSizes.size_16),
        LmuContentTile(
          content: LmuListItem.action(
            title: driver.allBenefitsTitle,
            trailingTitle: driver.allBenefitsCount,
            actionType: LmuListItemAction.chevron,
            onTap: driver.onAllBenefitsPressed,
          ),
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuContentTile(
          contentList: driver.benefitsCategories
              .mapIndexed(
                (index, benefit) => LmuListItem.action(
                  key: Key("benefit_category_${benefit.hashCode}"),
                  title: benefit.title,
                  subtitle: benefit.description,
                  leadingArea: LmuInListBlurEmoji(emoji: benefit.emoji),
                  trailingTitle: benefit.benefits.length.toString(),
                  hasDivider: index != driver.benefitsCategories.length - 1,
                  actionType: LmuListItemAction.chevron,
                  onTap: () => driver.onBenefitCategoryPressed(benefit),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: LmuSizes.size_32),
        const BenefitSuggestionTile(),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  @override
  WidgetDriverProvider<BenefitsPageDriver> get driverProvider => $BenefitsPageDriverProvider();
}
