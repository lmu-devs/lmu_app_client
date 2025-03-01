import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../bloc/links/links.dart';
import '../../repository/api/models/links/link_model.dart';
import '../../service/home_preferences_service.dart';
import '../favicon_fallback.dart';
import 'favorite_link_row_loading.dart';

class FavoriteLinkRow extends StatelessWidget {
  const FavoriteLinkRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinksCubit, LinksState>(
      bloc: GetIt.I.get<LinksCubit>(),
      builder: (context, state) {
        if (state is LinksLoadSuccess) {
          final List<LinkModel> fetchedLinks = state.links;
          return ValueListenableBuilder<List<String>>(
            valueListenable: GetIt.I<HomePreferencesService>().likedLinksNotifier,
            builder: (context, likedLinks, child) {
              final favoriteLinks = fetchedLinks.where((link) => likedLinks.contains(link.title)).toList()
                ..sort((a, b) => likedLinks.indexOf(a.title).compareTo(likedLinks.indexOf(b.title)));

              return likedLinks.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: LmuSizes.size_4),
                      child: SizedBox(
                        height: LmuSizes.size_48,
                        width: double.infinity,
                        child: AnimatedReorderableListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_12),
                          longPressDraggable: false,
                          items: favoriteLinks,
                          insertDuration: const Duration(milliseconds: 1200),
                          removeDuration: const Duration(milliseconds: 1000),
                          insertItemBuilder: (child, animation) => reorderableListAnimation(animation, child),
                          removeItemBuilder: (child, animation) =>
                              reorderableListAnimation(animation, child, isReverse: true),
                          onReorder: (oldIndex, newIndex) {
                            final order = List.of(likedLinks);
                            final item = order.removeAt(oldIndex);
                            order.insert(newIndex, item);
                            GetIt.I<HomePreferencesService>().updateLikedLinks(order);
                          },
                          isSameItem: (a, b) => a == b,
                          itemBuilder: (context, index) {
                            final link = favoriteLinks[index];

                            return Padding(
                              key: ValueKey(link.title),
                              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
                              child: LmuButton(
                                emphasis: ButtonEmphasis.secondary,
                                title: link.title,
                                leadingWidget: link.faviconUrl != null && link.faviconUrl!.isNotEmpty
                                    ? LmuCachedNetworkImage(
                                        imageUrl: link.faviconUrl!,
                                        height: LmuIconSizes.small,
                                        width: LmuIconSizes.small,
                                      )
                                    : const FaviconFallback(size: LmuIconSizes.small),
                                onTap: () => LmuUrlLauncher.launchWebsite(
                                  url: link.url,
                                  context: context,
                                  mode: LmuUrlLauncherMode.externalApplication,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          );
        }

        return const FavoriteLinkRowLoading();
      },
    );
  }
}
