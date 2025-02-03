import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/sports.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ForYouLoadingView extends StatelessWidget {
  const ForYouLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuSkeleton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => LmuButton(
                  title: BoneMock.words(1),
                  emphasis: ButtonEmphasis.secondary,
                  state: ButtonState.disabled,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuContentTile(
            content: List.generate(
              1,
              (index) => const LmuListItemLoading(
                titleLength: 3,
                action: LmuListItemAction.checkbox,
              ),
            ),
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              const LmuTileHeadlineLoading(),
              LmuContentTile(
                content: List.generate(
                  2,
                  (index) => const LmuListItemLoading(
                    titleLength: 3,
                    trailingSubtitleLength: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadlineLoading(),
        ),
        GetIt.I.get<CinemaService>().movieTeaserList,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadlineLoading(),
        ),
        LmuSkeleton(child: GetIt.I.get<SportsService>().showEntryPoint(onTap: () {})),
        const SizedBox(height: LmuSizes.size_32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuContentTile(
            content: List.generate(
              4,
              (index) => LmuListItemLoading(
                titleLength: 3,
                subtitleLength: 7,
                mainContentAlignment: MainContentAlignment.top,
                hasDivier: index < 3,
                leadingArea: const Padding(
                  padding: EdgeInsets.only(top: LmuSizes.size_4),
                  child: LmuIcon(
                    icon: LucideIcons.external_link,
                    size: 18,
                  ),
                ),
                trailingArea: const Padding(
                  padding: EdgeInsets.only(top: LmuSizes.size_4),
                  child: LmuIcon(
                    icon: LucideIcons.external_link,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}
