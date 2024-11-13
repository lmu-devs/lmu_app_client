import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuListDropdown extends StatelessWidget {
  const LmuListDropdown({
    Key? key,
    required this.title,
    this.titleColor,
    required this.items,
    this.initialValue = false,
    this.duration = const Duration(milliseconds: 300), // Add duration parameter
  }) : super(key: key);

  final String title;
  final Color? titleColor;
  final List<LmuListItem> items;
  final bool initialValue;
  final Duration duration;

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
                  opacity: animation,
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
                      children: items,
                    )
                  : const SizedBox.shrink(
                      key: ValueKey<bool>(false),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
