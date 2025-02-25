import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'cinema_card_loading.dart';
import 'screenings_card_loading.dart';

class CinemaLoadingView extends StatelessWidget {
  const CinemaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuTileHeadline.base(title: context.locals.cinema.cinemasTitle),
            ...List.generate(4, (index) {
              return const CinemaCardLoading();
            }),
            const SizedBox(height: LmuSizes.size_32),
            LmuTileHeadline.base(
              title: context.locals.cinema.upcomingTitle,
              bottomWidget: Align(
                alignment: Alignment.centerLeft,
                child: LmuSkeleton(
                  child: Wrap(
                    spacing: LmuSizes.size_8,
                    runSpacing: LmuSizes.size_4,
                    children: List.generate(
                      3,
                      (index) => LmuButton(
                        leadingWidget: index == 0
                            ? StarIcon(
                                disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                              )
                            : null,
                        title: BoneMock.words(1),
                        emphasis: ButtonEmphasis.secondary,
                        state: ButtonState.disabled,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ...List.generate(4, (index) {
              return const ScreeningCardLoading();
            }),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
