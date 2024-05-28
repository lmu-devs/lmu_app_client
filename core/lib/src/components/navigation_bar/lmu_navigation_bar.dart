import 'package:core/components.dart';
import 'package:flutter/material.dart';

class LmuNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const LmuNavigationBar({
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
        color: backgroundColor ?? Colors.red,
        child: SafeArea(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 48,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
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
  Size get preferredSize => const Size.fromHeight(48);
}
