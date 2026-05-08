import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../repository/api/models/links/link_model.dart';
import '../../service/home_preferences_service.dart';
import 'link_card.dart';

class FavoriteLinkSection extends StatefulWidget {
  const FavoriteLinkSection({
    super.key,
    required this.links,
  });

  final List<LinkModel> links;

  @override
  State<FavoriteLinkSection> createState() => _FavoriteLinkSectionState();
}

class _FavoriteLinkSectionState extends State<FavoriteLinkSection> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<LinkModel> _displayedLinks = [];
  final _homeService = GetIt.I<HomePreferencesService>();

  @override
  void initState() {
    super.initState();
    _initializeList();
    _homeService.likedLinksNotifier.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    _homeService.likedLinksNotifier.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _initializeList() {
    final likedLinkIds = _homeService.likedLinksNotifier.value;
    final initialLinks = widget.links
        .where((link) => likedLinkIds.contains(link.id))
        .toList()
      ..sort((a, b) =>
          likedLinkIds.indexOf(a.id).compareTo(likedLinkIds.indexOf(b.id)));

    _displayedLinks.addAll(initialLinks);
  }

  void _onFavoritesChanged() {
    final likedLinkIds = _homeService.likedLinksNotifier.value;
    final newFavoriteLinks = widget.links
        .where((link) => likedLinkIds.contains(link.id))
        .toList()
      ..sort((a, b) =>
          likedLinkIds.indexOf(a.id).compareTo(likedLinkIds.indexOf(b.id)));

    for (int i = _displayedLinks.length - 1; i >= 0; i--) {
      final link = _displayedLinks[i];
      if (!likedLinkIds.contains(link.id)) {
        final removedLink = _displayedLinks.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
              (context, animation) => _buildAnimatedItem(removedLink, animation),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    for (int i = 0; i < newFavoriteLinks.length; i++) {
      final link = newFavoriteLinks[i];
      if (i >= _displayedLinks.length || _displayedLinks[i].id != link.id) {
        _displayedLinks.insert(i, link);
        _listKey.currentState?.insertItem(
          i,
          duration: const Duration(milliseconds: 450),
        );
      }
    }
  }

  Widget _buildAnimatedItem(LinkModel link, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: LinkCard(link: link),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StarIcon(
          size: LmuIconSizes.small,
          disabledColor:
              context.colors.neutralColors.textColors.weakColors.base,
        ),
        const SizedBox(height: LmuSizes.size_12),
        ValueListenableBuilder<List<String>>(
          valueListenable: _homeService.likedLinksNotifier,
          builder: (context, likedLinkIds, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: likedLinkIds.isNotEmpty
                  ? LmuContentTile(
                      key: const ValueKey("favorite_list"),
                      content: AnimatedList(
                        key: _listKey,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        initialItemCount: _displayedLinks.length,
                        itemBuilder: (context, index, animation) {
                          if (index >= _displayedLinks.length) {
                            return const SizedBox.shrink();
                          }
                          return _buildAnimatedItem(
                              _displayedLinks[index], animation);
                        },
                      ),
                    )
                  : Padding(
                      key: const ValueKey("empty_state"),
                      padding: const EdgeInsets.only(bottom: LmuSizes.size_8),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: PlaceholderTile(
                          minHeight: LmuSizes.size_72,
                          content: [
                            LmuText.body(
                              context.locals.home.favoriteLinksEmptyBefore,
                              color: context.colors.neutralColors.textColors
                                  .mediumColors.base,
                              textAlign: TextAlign.center,
                            ),
                            StarIcon(
                              isActive: false,
                              disabledColor: context.colors.neutralColors
                                  .textColors.weakColors.base,
                              size: LmuSizes.size_16,
                            ),
                            LmuText.body(
                              context.locals.home.favoriteLinksEmptyAfter,
                              color: context.colors.neutralColors.textColors
                                  .mediumColors.base,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
