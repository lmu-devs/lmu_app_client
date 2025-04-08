import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class RoomfinderLoadingView extends StatelessWidget {
  const RoomfinderLoadingView({super.key});

  final loadingTileCount = const [1, 4, 2, 3];

  @override
  Widget build(BuildContext context) {
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: LmuSizes.size_24,
                  child: StarIcon(isActive: false, size: LmuIconSizes.small, disabledColor: starColor),
                ),
                const SizedBox(height: LmuSizes.size_12),
                LmuContentTile(
                  contentList: List.generate(
                    1,
                    (index) => const LmuListItemLoading(
                      titleLength: 2,
                      trailingTitleLength: 1,
                      action: LmuListItemAction.chevron,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                const LmuTileHeadlineLoading(titleLength: 2),
                Row(
                  children: [
                    LmuMapImageButton(onTap: () {}),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuIconButton(
                      icon: LucideIcons.search,
                      isDisabled: true,
                      onPressed: () {},
                    ),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuButton(
                      title: context.locals.roomfinder.alphabetical,
                      emphasis: ButtonEmphasis.secondary,
                      state: ButtonState.disabled,
                      trailingIcon: LucideIcons.chevron_down,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Column(
              children: List.generate(
                loadingTileCount.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LmuContentTile(
                      contentList: List.generate(
                        loadingTileCount[index],
                        (index) => const LmuListItemLoading(
                          titleLength: 2,
                          trailingTitleLength: 1,
                          action: LmuListItemAction.chevron,
                        ),
                      ),
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_64)
        ],
      ),
    );
  }
}
