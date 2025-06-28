import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../themes.dart';

class LmuListDropdown extends StatelessWidget {
  const LmuListDropdown({
    super.key,
    required this.title,
    this.titleColor,
    required this.items,
    this.initialValue = false,
    this.duration = const Duration(milliseconds: 300),
    this.hasDivider = false,
  });

  final String title;
  final Color? titleColor;
  final List<LmuListItem> items;
  final bool initialValue;
  final Duration duration;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    final valueNotifier = ValueNotifier<bool>(initialValue);
    return Column(
      children: [
        LmuListItem.action(
          hasHorizontalPadding: false,
          subtitle: title,
          subtitleTextColor: titleColor,
          initialValue: initialValue,
          mainContentAlignment: MainContentAlignment.center,
          actionType: LmuListItemAction.dropdown,
          onChange: (value) => valueNotifier.value = value,
        ),
        ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) => AnimatedSize(
            duration: duration,
            curve: Curves.easeInOut, // Choose your preferred curve
            child: AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              },
              switchInCurve: LmuAnimations.slowSmooth,
              switchOutCurve: LmuAnimations.slowSmooth.flipped,
              duration: duration,
              child: value
                  ? Column(
                      key: const ValueKey<bool>(true),
                      children: [...items, const SizedBox(height: 12)],
                    )
                  : const SizedBox.shrink(
                      key: ValueKey<bool>(false),
                    ),
            ),
          ),
        ),
        if (hasDivider) const LmuDivider(),
      ],
    );
  }
}
