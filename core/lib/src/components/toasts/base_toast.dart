import 'package:core/components.dart';
import 'package:core/src/constants/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  base,
  success,
  error,
  warning,
}

class LmuToast {
  static void removeAll({
    required BuildContext context,
  }) {
    final fToast = FToast();
    fToast.init(context);

    fToast.removeCustomToast();
  }

  static void show({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    ToastType type = ToastType.base,
    Duration? duration,
  }) {
    final fToast = FToast();
    fToast.init(context);

    final toast = SlideTransition(
      position: TweenSequence<Offset>([
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0.0, 0.0),
          ).chain(CurveTween(curve: LmuAnimations.quick)),
          weight: 1.0,
        ),
      ]).animate(
        AnimationController(
          vsync: Navigator.of(context),
          duration: const Duration(milliseconds: 1000),
        )..forward(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16, vertical: LmuSizes.size_8),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.base,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: context.colors.neutralColors.borderColors.seperatorLight,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: LmuSizes.size_8,
              height: LmuSizes.size_8,
              decoration: BoxDecoration(
                color: type.color(context.colors),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: LmuSizes.size_12),
            Flexible(
              child: LmuText.bodySmall(
                message,
                weight: FontWeight.w600,
                customOverFlow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            if (actionText != null && onActionPressed != null) ...[
              Row(
                children: [
                  const SizedBox(width: LmuSizes.size_8),
                  Container(
                    width: 1,
                    height: 20,
                    color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  LmuButton(
                    title: actionText,
                    onTap: () {
                      onActionPressed();
                      fToast.removeCustomToast();
                    },
                    size: ButtonSize.medium,
                    emphasis: ButtonEmphasis.link,
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: duration ??
          _calculateDuration(
            messages: [message, if (actionText != null && onActionPressed != null) actionText],
            hasAction: onActionPressed != null,
          ),
      fadeDuration: const Duration(milliseconds: 200),
    );
  }

  /// Calculates the duration of the toast based on the number of words in the message
  static Duration _calculateDuration({
    required List<String> messages,
    bool hasAction = false,
  }) {
    int wordCount = messages
        .where((msg) => msg.trim().isNotEmpty) // Filter out empty/whitespace-only strings
        .map((msg) => msg.trim().split(RegExp(r'\s+')).length) // Split into words
        .fold(0, (sum, count) => sum + count); // Sum up word counts

    int durationMs = 0;
    if (hasAction) {
      // Add 1 second for the action button
      durationMs += 1000;
    }

    // Base duration: 1 second + 250ms per word
    durationMs += 1000 + (wordCount * 250);

    // Clamp between 1,6 seconds and 5 seconds
    return Duration(milliseconds: durationMs.clamp(1600, 4000));
  }
}

extension ToastTypeExtension on ToastType {
  Color color(LmuColors colors) {
    switch (this) {
      case ToastType.success:
        return colors.successColors.textColors.strongColors.base;
      case ToastType.error:
        return colors.dangerColors.textColors.strongColors.base;
      case ToastType.warning:
        return colors.warningColors.textColors.strongColors.base;
      case ToastType.base:
        return colors.neutralColors.textColors.strongColors.base;
    }
  }
}
