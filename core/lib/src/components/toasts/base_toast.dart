import 'package:core/components.dart';
import 'package:core/src/constants/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sprung/sprung.dart';

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
    Duration duration = const Duration(seconds: 3),
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
          ).chain(CurveTween(curve: Sprung.custom(
            damping: 30,
            stiffness: 200.0,
            mass: 1.0,
          ))),
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
                    color: context
                        .colors.neutralColors.backgroundColors.mediumColors.base,
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
      toastDuration: duration,
      fadeDuration: const Duration(milliseconds: 200),
    );
  }


  // Convenience methods for different toast types
  static void showSuccess({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 3),
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
    Duration duration = const Duration(seconds: 3),
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
    Duration duration = const Duration(seconds: 3),
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
}
