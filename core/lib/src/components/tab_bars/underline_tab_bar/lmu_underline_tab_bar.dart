import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuUnderlineTabBar extends StatelessWidget {
  const LmuUnderlineTabBar({
    super.key,
    required this.items,
    required this.onTabChanged,
    required this.activeTabIndexNotifier,
    this.hasDivider = false,
  });

  final List<LmuUnderlineTabBarItemData> items;
  final void Function(int) onTabChanged;
  final ValueNotifier<int> activeTabIndexNotifier;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: context.colors.neutralColors.backgroundColors.base,
          height: 46,
          child: Padding(
            padding: const EdgeInsets.only(top: LmuSizes.size_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items.asMap().entries.map((entry) {
                return Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: activeTabIndexNotifier,
                    builder: (context, activeIndex, _) {
                      return GestureDetector(
                        onTap: () => onTabChanged(entry.key),
                        child: LmuUnderlineTabBarItem(
                          title: entry.value.title,
                          isActive: activeIndex == entry.key,
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        if (hasDivider) const LmuDivider(),
      ],
    );
  }
}