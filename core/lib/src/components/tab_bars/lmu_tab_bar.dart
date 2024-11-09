import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import 'lmu_tab_bar_item.dart';

class LmuTabBar extends StatelessWidget {
  LmuTabBar({
    super.key,
    required this.items,
    required this.onTabChanged,
    ValueNotifier<int>? activeTabIndexNotifier,
  }) : _activeTabIndexNotifier = activeTabIndexNotifier ?? ValueNotifier(0);

  final void Function(int, LmuTabBarItemData) onTabChanged;
  final List<LmuTabBarItemData> items;
  final ValueNotifier<int> _activeTabIndexNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: LmuSizes.medium,
        bottom: LmuSizes.medium,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (_, index) {
            final tabItem = items[index];
            return Padding(
              padding: EdgeInsets.only(
                right: LmuSizes.mediumSmall,
                left: index == 0 ? LmuSizes.mediumLarge : 0,
              ),
              child: ValueListenableBuilder(
                valueListenable: _activeTabIndexNotifier,
                builder: (context, activeTabIndex, _) {
                  return LmuTabBarItem(
                    title: tabItem.title,
                    isActive: activeTabIndex == index,
                    leadingIcon: tabItem.leadingIcon,
                    trailingIcon: tabItem.trailingIcon,
                    onTap: () {
                      //_activeTabIndexNotifier.value = index;
                      onTabChanged.call(
                        index,
                        tabItem,
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
