import 'package:flutter/material.dart';
import 'package:animated_reorderable_list/animated_reorderable_list.dart';

import '../../../themes.dart';

class LmuReorderableFavoriteList extends StatelessWidget {
  const LmuReorderableFavoriteList({
    super.key,
    required this.favoriteIds,
    required this.placeholder,
    required this.onReorder,
    required this.itemBuilder,
  });

  final List<String> favoriteIds;
  final Widget placeholder;
  final void Function(int, int) onReorder;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: favoriteIds.isEmpty ? placeholder : null,
        ),
        AnimatedReorderableListView(
          physics: const NeverScrollableScrollPhysics(),
          longPressDraggable: false,
          shrinkWrap: true,
          items: favoriteIds,
          insertDuration: const Duration(milliseconds: 1200),
          removeDuration: const Duration(milliseconds: 1000),
          insertItemBuilder: (child, animation) => reorderableListAnimation(animation, child),
          removeItemBuilder: (child, animation) => reorderableListAnimation(animation, child, isReverse: true),
          onReorder: onReorder,
          isSameItem: (a, b) => a == b,
          itemBuilder: itemBuilder,
        ),
      ],
    );
  }
}
