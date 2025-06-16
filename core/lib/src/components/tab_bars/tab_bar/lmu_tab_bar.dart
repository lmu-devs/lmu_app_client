import 'package:flutter/material.dart';

import '../../../../components.dart';
import '../../../../constants.dart';
import '../../../../themes.dart';

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

  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _activeTabIndexNotifier = widget.activeTabIndexNotifier ?? ValueNotifier(_activeIndex);
    _scrollController = ScrollController();
    _tabKeys.addAll(List.generate(widget.items.length, (_) => GlobalKey()));

    _activeTabIndexNotifier.addListener(() => _centerSelectedItem(_activeTabIndexNotifier.value));
  }

  @override
  void dispose() {
    _activeTabIndexNotifier.removeListener(() => _centerSelectedItem(_activeTabIndexNotifier.value));
    super.dispose();
  }

  double get _startEnditemPadding {
    if (widget.hasDefaultPaddings) {
      return LmuSizes.size_16;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          color: context.colors.neutralColors.backgroundColors.base,
          padding: EdgeInsets.only(
            top: widget.hasDefaultPaddings ? LmuSizes.size_12 : 0,
            bottom: widget.hasDefaultPaddings ? LmuSizes.size_12 : 0,
          ),
          child: SizedBox(
            height: 36 * MediaQuery.of(context).textScaler.textScaleFactor,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.items.length,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (_, index) {
                final tabItem = widget.items[index];
                final isFirst = index == 0;
                final isLast = index == widget.items.length - 1;
                final isActive = _activeIndex == index;

                return Row(
                  key: Key('tab_bar_item_row_$index'),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: isLast ? _startEnditemPadding : LmuSizes.size_4,
                        left: isFirst ? _startEnditemPadding : LmuSizes.size_4,
                      ),
                      child: GestureDetector(
                        key: _tabKeys[index],
                        onTap: () => widget.onTabChanged.call(index, tabItem),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: LmuTabBarItem(
                            key: ValueKey('item_$index $isActive'),
                            title: tabItem.title,
                            isActive: isActive,
                            leadingWidget: tabItem.leadingWidget,
                            trailingWidget: tabItem.trailingWidget,
                          ),
                        ),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _activeIndex = index);

        // Wait one more frame for layout to reflect the new active index
        WidgetsBinding.instance.addPostFrameCallback((_) {
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
        });
      }
    });
  }
}
