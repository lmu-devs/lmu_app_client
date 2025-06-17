import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components.dart';
import '../../../themes.dart';
import '../../constants/constants.dart';

enum ToastType { base, success, error, warning }

class LmuToast {
  LmuToast._(BuildContext context) : _fToast = FToast()..init(context);
  final FToast _fToast;

  static LmuToast of(BuildContext context) => LmuToast._(context);

  static void show({
    required BuildContext context,
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    ToastType type = ToastType.base,
    Duration? duration,
  }) =>
      LmuToast._(context)._showToast(
        message: message,
        actionText: actionText,
        onActionPressed: onActionPressed,
        type: type,
        duration: duration,
      );

  void showToast({
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    ToastType type = ToastType.base,
    Duration? duration,
  }) =>
      _showToast(
        message: message,
        actionText: actionText,
        onActionPressed: onActionPressed,
        type: type,
        duration: duration,
      );

  void _showToast({
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    ToastType type = ToastType.base,
    Duration? duration,
  }) {
    final toast = _buildToast(
      message: message,
      actionText: actionText,
      onActionPressed: onActionPressed,
      type: type,
    );

    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: duration ??
          _calculateDuration(
            messages: [message, if (actionText != null) actionText],
            hasAction: onActionPressed != null,
          ),
      fadeDuration: const Duration(milliseconds: 200),
    );
  }

  Widget _buildToast({
    required String message,
    String? actionText,
    VoidCallback? onActionPressed,
    required ToastType type,
  }) {
    return Builder(
      builder: (context) {
        return SafeArea(
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
                          _fToast.removeCustomToast();
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
      },
    );
  }

  static void removeAll({required BuildContext context}) {
    final fToast = FToast()..init(context);
    fToast.removeCustomToast();
  }

  static Duration _calculateDuration({
    required List<String> messages,
    bool hasAction = false,
  }) {
    int wordCount = messages
        .where((msg) => msg.trim().isNotEmpty)
        .map((msg) => msg.trim().split(RegExp(r'\s+')).length)
        .fold(0, (sum, count) => sum + count);

    int durationMs = 1000 + (wordCount * 250);
    if (hasAction) durationMs += 1000;
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
