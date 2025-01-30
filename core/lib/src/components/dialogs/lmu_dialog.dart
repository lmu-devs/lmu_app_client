import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuDialogAction {
  const LmuDialogAction({
    required this.title,
    required this.onPressed,
    this.icon,
    this.isSecondary = false,
  });

  final String title;
  final void Function(BuildContext dialogContext) onPressed;
  final IconData? icon;
  final bool isSecondary;
}

class LmuDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String description,
    required List<LmuDialogAction> buttonActions,
  }) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        final neutralColors = dialogContext.colors.neutralColors;

        return Dialog(
          elevation: 2,
          backgroundColor: neutralColors.backgroundColors.tile,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(LmuSizes.size_12)),
          child: Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LmuText.body(
                  title,
                  color: neutralColors.textColors.strongColors.base,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: LmuSizes.size_4),
                LmuText.body(
                  description,
                  color: neutralColors.textColors.mediumColors.base,
                ),
                const SizedBox(height: LmuSizes.size_20),
                LayoutBuilder(
                  builder: (_, constraints) {
                    final gaps = (buttonActions.length - 1) * LmuSizes.size_8;
                    final buttonWidth = (constraints.maxWidth - gaps) / buttonActions.length;
                    return Row(
                      children: buttonActions
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(right: buttonActions.last == e ? 0 : LmuSizes.size_8),
                              child: SizedBox(
                                width: buttonWidth,
                                child: LmuButton(
                                  title: e.title,
                                  emphasis: e.isSecondary ? ButtonEmphasis.secondary : ButtonEmphasis.primary,
                                  trailingIcon: e.icon,
                                  onTap: () => e.onPressed(dialogContext),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
