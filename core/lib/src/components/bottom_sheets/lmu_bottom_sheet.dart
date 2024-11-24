import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LmuSizes.xlarge),
          topRight: Radius.circular(LmuSizes.xlarge),
        ),
      ),
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
      bounce: true,
      animationCurve: LmuAnimations.slowSmooth,
      duration: const Duration(milliseconds: 500),
      closeProgressThreshold: .9,
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(),
        child: content,
      ),
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
