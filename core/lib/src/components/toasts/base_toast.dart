import 'package:core/components.dart';
import 'package:core/src/constants/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  default_,
  success,
  error,
  warning,
}

class LmuCustomToast {
  static void show({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    ToastType type = ToastType.default_,
    Duration? duration,
  }) {
    final fToast = FToast();
    fToast.init(context);

    Color getDotColor() {
      switch (type) {
        case ToastType.success:
          return context.colors.successColors.textColors.strongColors.base;
        case ToastType.error:
          return context.colors.dangerColors.textColors.strongColors.base;
        case ToastType.warning:
          return context.colors.warningColors.textColors.strongColors.base;
        case ToastType.default_:
          return context.colors.neutralColors.textColors.strongColors.base;
      }
    }

    Widget toast = SlideTransition(
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
              width: LmuSizes.mediumSmall,
              height: LmuSizes.mediumSmall,
              decoration: BoxDecoration(
                color: getDotColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            LmuText.bodySmall(
              message,
              weight: FontWeight.w600,
            ),
            if (actionText != null && onActionPressed != null) ...[
              Row(
                children: [
                  const SizedBox(width: LmuSizes.mediumSmall),
                  Container(
                    width: 1,
                    height: 20,
                    color: context.colors.neutralColors.backgroundColors
                        .mediumColors.base,
                  ),
                  const SizedBox(width: LmuSizes.mediumSmall),
                  LmuButton(
                    title: actionText,
                    onTap: onActionPressed,
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
          calculateDuration(
            messages: [
              message,
              if (actionText != null && onActionPressed != null) actionText
            ],
            hasAction: onActionPressed != null,
          ),
      fadeDuration: const Duration(milliseconds: 200),
    );
  }

  // Convenience methods for different toast types
  static void showSuccess({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      actionText: actionText,
      type: ToastType.success,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      actionText: actionText,
      type: ToastType.error,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      actionText: actionText,
      type: ToastType.warning,
      onActionPressed: onActionPressed,
      duration: duration,
    );
  }

  /// Calculates the duration of the toast based on the number of words in the message
  static Duration calculateDuration(
      {required List<String> messages, bool hasAction = false}) {
    int wordCount = messages
        .where((msg) =>
            msg.trim().isNotEmpty) // Filter out empty/whitespace-only strings
        .map((msg) =>
            msg.trim().split(RegExp(r'\s+')).length) // Split into words
        .fold(0, (sum, count) => sum + count); // Sum up word counts

    int durationMs = 0;
    if (hasAction) {
      // Add 1 second for the action button
      print("has action");
      durationMs += 1000;
    }

    // Base duration: 1 second + 250ms per word
    durationMs += 1000 + (wordCount * 250);

    print(durationMs);
    print(wordCount);

    // Clamp between 1,6 seconds and 5 seconds
    return Duration(milliseconds: durationMs.clamp(1600, 4000));
  }
}
