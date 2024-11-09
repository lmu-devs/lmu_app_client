import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class LmuBottomSheet {
  static void show(
    BuildContext context, {
    required Widget content,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      builder: (_) {
        return LmuBottomSheetContent(content: content);
      },
    );
  }

  static void showExtended(
    BuildContext context, {
    required Widget content,
  }) {
    showBarModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LmuSizes.mediumLarge),
          topRight: Radius.circular(LmuSizes.mediumLarge),
        ),
      ),
      animationCurve: Curves.easeOutCubic,
      bounce: true,
      duration: const Duration(milliseconds: 500),
      clipBehavior: Clip.antiAlias,
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      builder: (context) => Padding(
          padding: const EdgeInsets.only(
            top: LmuSizes.mediumLarge,
            left: LmuSizes.mediumLarge,
            right: LmuSizes.mediumLarge,
          ),
          child: content),
    );
  }
}

class LmuBottomSheetContent extends StatelessWidget {
  const LmuBottomSheetContent({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: LmuSizes.mediumLarge,
        left: LmuSizes.mediumLarge,
        right: LmuSizes.mediumLarge,
        bottom: LmuSizes.xxxlarge,
      ),
      child: content,
    );
  }
}
