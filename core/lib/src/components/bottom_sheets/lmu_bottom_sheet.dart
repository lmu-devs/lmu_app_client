import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

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
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.mediumLarge,
            right: LmuSizes.mediumLarge,
            top: LmuSizes.mediumSmall,
          ),
          child: content,
        );
      },
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
