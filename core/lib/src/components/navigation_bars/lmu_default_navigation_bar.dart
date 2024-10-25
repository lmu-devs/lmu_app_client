import 'package:core/components.dart';
import 'package:core/src/core.dart';
import 'package:flutter/material.dart';

class LmuDefaultNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const LmuDefaultNavigationBar({
    this.title,
    this.leadingWidget,
    this.backgroundColor,
    this.trailingWidget,
    super.key,
  });

  final String? title;
  final Widget? leadingWidget;
  final Color? backgroundColor;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: backgroundColor ?? context.colors.neutralColors.backgroundColors.base,
        child: SafeArea(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 48,
            ),
            padding: const EdgeInsets.only(
              top: 24,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (leadingWidget != null)
                      Row(
                        children: [
                          leadingWidget!,
                          const SizedBox(
                            width: 16,
                          )
                        ],
                      ),
                    if (title != null) LmuText.h1(title),
                  ],
                ),
                if (trailingWidget != null) trailingWidget!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
