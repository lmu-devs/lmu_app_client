import 'package:core/components.dart';
import 'package:core/constants.dart';
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
            padding: const EdgeInsets.only(top: LmuSizes.size_4),
            child: SizedBox(
              height: LmuSizes.size_48,
              child: LmuSkeleton(
                child: LmuButtonRow(
                  buttons: List.generate(
                    favoriteLinks.length,
                    (index) => LmuButton(
                      emphasis: ButtonEmphasis.secondary,
                      title: BoneMock.words(1),
                      leadingWidget: const LmuFaviconFallback(size: LmuIconSizes.small),
                    ),
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
