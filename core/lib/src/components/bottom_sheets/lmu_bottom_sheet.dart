import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../constants.dart';
import '../../../themes.dart';

class LmuBottomSheet {
  static void show(
    BuildContext context, {
    required Widget content,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      useRootNavigator: true,
      animationCurve: LmuAnimations.fastSmooth,
      duration: const Duration(milliseconds: 400),
      closeProgressThreshold: .9,
      shape: const RoundedSuperellipseBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LmuSizes.size_24),
          topRight: Radius.circular(LmuSizes.size_24),
        ),
      ),
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withValues(alpha: 0.8)
          : Colors.black.withValues(alpha: 0.6),
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      builder: (_) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(LmuSizes.size_24),
            topRight: Radius.circular(LmuSizes.size_24),
          ),
          border: Border(
            top: BorderSide(
              color: context.colors.neutralColors.borderColors.seperatorLight,
              width: .8,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: LmuSizes.size_16,
            left: LmuSizes.size_16,
            right: LmuSizes.size_16,
            bottom: LmuSizes.size_48,
          ),
          child: content,
        ),
      ),
    );
  }

  static void showExtended(
    BuildContext context, {
    required Widget content,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedSuperellipseBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LmuSizes.size_16),
          topRight: Radius.circular(LmuSizes.size_16),
        ),
      ),
      animationCurve: LmuAnimations.slowSmooth,
      duration: const Duration(milliseconds: 500),
      barrierColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black.withValues(alpha: 0.8)
          : Colors.black.withValues(alpha: 0.6),
      closeProgressThreshold: .9,
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(LmuSizes.size_16),
            topRight: Radius.circular(LmuSizes.size_16),
          ),
          border: Border(
            top: BorderSide(
              color: context.colors.neutralColors.borderColors.seperatorLight,
              width: .8,
            ),
          ),
        ),
        child: content,
      ),
    ).whenComplete(LmuVibrations.secondary);
  }
}
