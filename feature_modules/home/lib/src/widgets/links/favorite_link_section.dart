import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';

import '../../repository/api/models/links/link_model.dart';
import '../../service/home_preferences_service.dart';
import 'link_card.dart';

class FavoriteLinkSection extends StatelessWidget {
  const FavoriteLinkSection({
    super.key,
    required this.links,
    required this.isSearchActive,
  });

  final List<LinkModel> links;
  final bool isSearchActive;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: GetIt.I<HomePreferencesService>().likedLinksNotifier,
      builder: (context, likedLinkTitles, child) {
        if (isSearchActive) {
          return const SizedBox.shrink();
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
              ),
            );
          },
          child: likedLinkTitles.isNotEmpty
              ? Column(
                  key: const ValueKey("favorite_list"),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StarIcon(
                      disabledColor: context.colors.neutralColors.backgroundColors.strongColors.active,
                    ),
                    const SizedBox(height: LmuSizes.size_12),
                    LmuContentTile(
                      content: links
                          .where((link) => likedLinkTitles.contains(link.title))
                          .map((link) => LinkCard(link: link))
                          .toList(),
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                  ],
                )
              : Padding(
                  key: const ValueKey("empty_state"),
                  padding: const EdgeInsets.only(bottom: LmuSizes.size_32),
                  child: PlaceholderTile(
                    minHeight: LmuSizes.size_72,
                    content: [
                      LmuText.body(
                        context.locals.home.favoriteLinksEmptyBefore,
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                        textAlign: TextAlign.center,
                      ),
                      StarIcon(
                        isActive: false,
                        disabledColor: context.colors.neutralColors.textColors.weakColors.base,
                        size: LmuSizes.size_16,
                      ),
                      LmuText.body(
                        context.locals.home.favoriteLinksEmptyAfter,
                        color: context.colors.neutralColors.textColors.mediumColors.base,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
