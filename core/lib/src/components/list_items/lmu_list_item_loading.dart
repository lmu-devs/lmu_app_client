import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/lmu_sizes.dart';
import '../actions/lmu_list_item_action.dart';
import '../skeletons/lmu_skeleton.dart';
import 'lmu_list_item.dart';

class LmuListItemLoading extends StatelessWidget {
  const LmuListItemLoading({
    super.key,
    this.titleLength,
    this.trailingTitleLength,
    this.subtitleLength,
    this.trailingSubtitleLength,
    this.leadingArea,
    this.trailingArea,
    this.action,
    this.hasDivier = false,
    this.hasHorizontalPadding = true,
    this.hasVerticalPadding = true,
    this.mainContentAlignment,
  });

  final int? titleLength;
  final int? trailingTitleLength;
  final int? subtitleLength;
  final int? trailingSubtitleLength;
  final Widget? leadingArea;
  final Widget? trailingArea;
  final LmuListItemAction? action;
  final bool hasDivier;
  final bool hasHorizontalPadding;
  final bool hasVerticalPadding;
  final MainContentAlignment? mainContentAlignment;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuListItem.base(
        leadingArea: leadingArea,
        title: titleLength != null ? BoneMock.words(titleLength!) : null,
        trailingTitle: trailingTitleLength != null ? BoneMock.words(trailingTitleLength!) : null,
        trailingSubtitle: trailingSubtitleLength != null ? BoneMock.words(trailingSubtitleLength!) : null,
        subtitle: subtitleLength != null ? BoneMock.words(subtitleLength!) : null,
        trailingArea: action?.loadingWidget ?? trailingArea,
        hasDivier: hasDivier,
        hasHorizontalPadding: hasHorizontalPadding,
        hasVerticalPadding: hasVerticalPadding,
        mainContentAlignment: mainContentAlignment,
      ),
    );
  }
}

extension _ActionLoading on LmuListItemAction {
  Widget get loadingWidget {
    if (LmuListItemAction.chevron == this || LmuListItemAction.dropdown == this) {
      return Container(
        width: LmuSizes.size_16,
        height: LmuSizes.size_16,
        color: Colors.red,
      );
    }

    if (this == LmuListItemAction.toggle) {
      return SizedBox(
        width: 46,
        height: 30,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(
              LmuSizes.size_32 / 2,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: LmuSizes.size_24,
      height: LmuSizes.size_24,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(LmuSizes.size_4),
        ),
      ),
    );
  }
}
