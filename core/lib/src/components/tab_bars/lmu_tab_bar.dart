import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import 'lmu_tab_bar_item.dart';

class LmuTabBar extends StatefulWidget {
  const LmuTabBar({
    super.key,
    required this.items,
    required this.onTabChanged,
    this.activeTabIndexNotifier,
  });

  final void Function(int, LmuTabBarItemData) onTabChanged;
  final List<LmuTabBarItemData> items;
  final ValueNotifier<int>? activeTabIndexNotifier;

  @override
  State<LmuTabBar> createState() => _LmuTabBarState();
}

class _LmuTabBarState extends State<LmuTabBar> {
  late ScrollController _scrollController;
  late ValueNotifier<int> _activeTabIndexNotifier;

  @override
  void initState() {
    super.initState();
    _activeTabIndexNotifier = widget.activeTabIndexNotifier ?? ValueNotifier(0);
    _scrollController = ScrollController();
  }

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
          itemCount: widget.items.length,
          controller: _scrollController,
          itemBuilder: (_, index) {
            final tabItem = widget.items[index];
            return Padding(
              padding: EdgeInsets.only(
                right: LmuSizes.mediumSmall,
                left: index == 0 ? LmuSizes.mediumLarge : 0,
              ),
              child: ValueListenableBuilder(
                valueListenable: _activeTabIndexNotifier,
                builder: (context, activeTabIndex, _) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: LmuTabBarItem(
                      key: ValueKey("item$index ${activeTabIndex == index}"),
                      title: tabItem.title,
                      isActive: activeTabIndex == index,
                      leadingIcon: tabItem.leadingIcon,
                      trailingIcon: tabItem.trailingIcon,
                      onTap: () {
//                        _scrollController.animateTo(offset, duration: Durations.medium1, curve: Curves.easeIn);
                        widget.onTabChanged.call(
                          index,
                          tabItem,
                        );
                      },
                    ),
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
