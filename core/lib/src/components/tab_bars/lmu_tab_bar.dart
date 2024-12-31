import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuTabBar extends StatefulWidget {
  const LmuTabBar({
    super.key,
    required this.items,
    required this.onTabChanged,
    this.activeTabIndexNotifier,
    this.hasDivider = false,
  });

  final void Function(int, LmuTabBarItemData) onTabChanged;
  final List<LmuTabBarItemData> items;
  final ValueNotifier<int>? activeTabIndexNotifier;
  final bool hasDivider;

  @override
  State<LmuTabBar> createState() => _LmuTabBarState();
}

class _LmuTabBarState extends State<LmuTabBar> {
  late ScrollController _scrollController;
  late ValueNotifier<int> _activeTabIndexNotifier;
  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();
    _activeTabIndexNotifier = widget.activeTabIndexNotifier ?? ValueNotifier(0);
    _scrollController = ScrollController();
    _tabKeys.addAll(List.generate(widget.items.length, (_) => GlobalKey()));

    _activeTabIndexNotifier.addListener(() => _centerSelectedItem(_activeTabIndexNotifier.value));
  }

  @override
  void dispose() {
    _activeTabIndexNotifier.removeListener(() => _centerSelectedItem(_activeTabIndexNotifier.value));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: context.colors.neutralColors.backgroundColors.base,
          padding: const EdgeInsets.only(
            top: LmuSizes.size_12,
            bottom: LmuSizes.size_12,
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
                final isFirst = index == 0;
                final isLast = index == widget.items.length - 1;
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: isLast ? LmuSizes.size_16 : LmuSizes.size_4,
                        left: isFirst ? LmuSizes.size_16 : LmuSizes.size_4,
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: _activeTabIndexNotifier,
                        builder: (context, activeTabIndex, _) {
                          return GestureDetector(
                            key: _tabKeys[index],
                            onTap: () => widget.onTabChanged.call(index, tabItem),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: LmuTabBarItem(
                                key: ValueKey('$index ${activeTabIndex == index}'),
                                title: tabItem.title,
                                isActive: activeTabIndex == index,
                                leadingIcon: tabItem.leadingIcon,
                                trailingIcon: tabItem.trailingIcon,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (tabItem.hasDivider && !isLast)
                      Container(
                        width: 2,
                        height: 32,
                        color: context.colors.neutralColors.borderColors.seperatorLight,
                      )
                  ],
                );
              },
            ),
          ),
        ),
        if (widget.hasDivider) const LmuDivider(),
      ],
    );
  }

  void _centerSelectedItem(int index) {
    final context = _tabKeys[index].currentContext;
    if (context != null) {
      // Get the position and size of the selected tab
      final renderBox = context.findRenderObject() as RenderBox;
      final tabPosition = renderBox.localToGlobal(Offset.zero);
      final tabWidth = renderBox.size.width;

      // Get screen width and current scroll position
      final screenWidth = MediaQuery.of(context).size.width;
      final listViewPosition = _scrollController.position.pixels;

      // Calculate the target offset to center the item
      double targetOffset = listViewPosition + tabPosition.dx + (tabWidth / 2) - (screenWidth / 2);

      // Clamp the target offset to avoid overscrolling
      targetOffset = targetOffset.clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      );

      // Animate the scroll to the target offset
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
