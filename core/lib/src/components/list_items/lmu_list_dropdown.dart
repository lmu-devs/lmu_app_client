import 'package:core/components.dart';
import 'package:flutter/material.dart';

class LmuListDropdown extends StatelessWidget {
  const LmuListDropdown({
    Key? key,
    required this.title,
    this.titleColor,
    required this.items,
    this.initialValue = false,
  }) : super(key: key);

  final String title;
  final Color? titleColor;
  final List<LmuListItem> items;
  final bool initialValue;

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
          child: const SizedBox.shrink(),
          builder: (context, value, child) => value
              ? Column(
                  children: items,
                )
              : child!,
        ),
      ],
    );
  }
}
