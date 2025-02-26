import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../service/home_preferences_service.dart';

class FavoriteLinkRowLoading extends StatelessWidget {
  const FavoriteLinkRowLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteLinks = GetIt.I.get<HomePreferencesService>().likedLinksNotifier.value;

    return favoriteLinks.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: LmuSizes.size_4, bottom: LmuSizes.size_8),
            child: LmuSkeleton(
              child: LmuButtonRow(
                buttons: List.generate(
                  favoriteLinks.length,
                  (index) => LmuButton(
                    emphasis: ButtonEmphasis.secondary,
                    title: BoneMock.words(1),
                    leadingWidget: Container(
                      decoration: BoxDecoration(
                        color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                        borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
                      ),
                      height: LmuIconSizes.small,
                      width: LmuIconSizes.small,
                    ),
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
