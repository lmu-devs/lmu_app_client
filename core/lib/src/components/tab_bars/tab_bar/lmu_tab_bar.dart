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
    this.hasDefaultPaddings = true,
    this.hasDivider = false,
  });

  final void Function(int, LmuTabBarItemData) onTabChanged;
  final List<LmuTabBarItemData> items;
  final ValueNotifier<int>? activeTabIndexNotifier;
  final bool hasDefaultPaddings;
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: context.colors.neutralColors.backgroundColors.base,
          padding: EdgeInsets.only(
            top: widget.hasDefaultPaddings ? LmuSizes.size_12 : 0,
            bottom: widget.hasDefaultPaddings ? LmuSizes.size_12 : 0,
          ),
          child: SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.items.length,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (_, index) {
                final tabItem = widget.items[index];
                final isFirst = index == 0;
                final isLast = index == widget.items.length - 1;
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: isLast
                            ? widget.hasDefaultPaddings
                                ? LmuSizes.size_16
                                : 0
                            : LmuSizes.size_4,
                        left: isFirst
                            ? widget.hasDefaultPaddings
                                ? LmuSizes.size_16
                                : 0
                            : LmuSizes.size_4,
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
                                key: ValueKey('item_$index ${activeTabIndex == index}'),
                                title: tabItem.title,
                                isActive: activeTabIndex == index,
                                leadingWidget: tabItem.leadingWidget,
                                trailingWidget: tabItem.trailingWidget,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (tabItem.hasDivider && !isLast)
                      Container(
                        width: 2,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(2),
                            bottom: Radius.circular(2),
                          ),
                          color: context.colors.neutralColors.borderColors.seperatorLight,
                        ),
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
      final renderBox = context.findRenderObject() as RenderBox;
      final tabPosition = renderBox.localToGlobal(Offset.zero);
      final tabWidth = renderBox.size.width;

      final screenWidth = MediaQuery.of(context).size.width;
      final listViewPosition = _scrollController.position.pixels;

      double targetOffset = listViewPosition + tabPosition.dx + (tabWidth / 2) - (screenWidth / 2);

      targetOffset = targetOffset.clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      );

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
