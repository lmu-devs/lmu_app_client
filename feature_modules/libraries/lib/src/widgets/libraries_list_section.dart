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
        final baseItems = items.take(isExpandable ? 3 : 4).toList();
        final additionalItems = items.skip(isExpandable ? 3 : 4).toList();

        return Column(
          children: [
            const SizedBox(height: LmuSizes.size_32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuTileHeadline.base(title: "$title • $count"),
                  LmuContentTile(
                    contentList: [
                      Column(children: baseItems),
                      if (isExpandable)
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: AnimatedSwitcher(
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: child,
                                ),
                              );
                            },
                            switchInCurve: LmuAnimations.slowSmooth,
                            switchOutCurve: LmuAnimations.slowSmooth.flipped,
                            duration: const Duration(milliseconds: 300),
                            child: showAll ? Column(children: additionalItems) : const SizedBox.shrink(),
                          ),
                        ),
                    ],
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
        );
      },
    );
  }
}
