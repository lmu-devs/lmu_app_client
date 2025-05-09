import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LibrariesListSection extends StatelessWidget {
  const LibrariesListSection({
    super.key,
    required this.title,
    required this.count,
    required this.items,
  });

  final String title;
  final int count;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final showAllNotifier = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: showAllNotifier,
      builder: (context, showAll, _) {
        final isExpandable = count > 4;
        final visibleItems = !isExpandable || showAll ? items : items.take(3).toList();

        return Column(
          children: [
            const SizedBox(height: LmuSizes.size_32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuTileHeadline.base(title: "$title • $count"),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Column(
                      key: ValueKey("$showAll • $title"),
                      children: [
                        LmuContentTile(
                          contentList: visibleItems,
                          contentTileType: isExpandable && !showAll ? ContentTileType.top : ContentTileType.middle,
                        ),
                        if (isExpandable && !showAll)
                          GestureDetector(
                            onTap: () => showAllNotifier.value = true,
                            child: LmuContentTile(
                              contentList: [
                                Center(
                                  child: LmuText.body(
                                    context.locals.app.showAll,
                                    weight: FontWeight.w600,
                                    color: context.colors.brandColors.textColors.strongColors.base,
                                  ),
                                ),
                              ],
                              padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_12),
                              contentTileType: ContentTileType.bottom,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
