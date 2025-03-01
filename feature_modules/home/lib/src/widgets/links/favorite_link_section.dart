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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StarIcon(
              size: LmuIconSizes.small,
              disabledColor: context.colors.neutralColors.textColors.weakColors.base,
            ),
            const SizedBox(height: LmuSizes.size_12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: likedLinkTitles.isNotEmpty
                  ? LmuContentTile(
                      key: const ValueKey("favorite_list"),
                      content: [
                        ...links.where((link) => likedLinkTitles.contains(link.title)).toList()
                          ..sort((a, b) => likedLinkTitles.indexOf(a.title).compareTo(likedLinkTitles.indexOf(b.title)))
                      ].map((link) => LinkCard(link: link)).toList(),
                    )
                  : Padding(
                      key: const ValueKey("empty_state"),
                      padding: const EdgeInsets.only(bottom: LmuSizes.size_8),
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
            ),
            const SizedBox(height: LmuSizes.size_32),
          ],
        );
      },
    );
  }
}
