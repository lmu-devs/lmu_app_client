import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../repository/api/models/links/link_model.dart';
import '../../service/home_preferences_service.dart';

class LinkCard extends StatelessWidget {
  const LinkCard({
    super.key,
    required this.link,
    this.additionalCallbackOnTap,
  });

  final LinkModel link;
  final VoidCallback? additionalCallbackOnTap;

  @override
  Widget build(BuildContext context) {
    final appLocals = context.locals.app;

    return ValueListenableBuilder<List<String>>(
      valueListenable: GetIt.I<HomePreferencesService>().likedLinksNotifier,
      builder: (context, likedLinkTitles, child) {
        final isFavorite = likedLinkTitles.contains(link.id);
        return LmuCard(
          title: link.title,
          subtitle: link.description,
          leadingIconAlignment: CrossAxisAlignment.start,
          leadingIcon: Padding(
            padding: const EdgeInsets.only(top: LmuSizes.size_2),
            child: link.faviconUrl != null && link.faviconUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(LmuRadiusSizes.xsmall),
                    child: LmuCachedNetworkImage(
                      imageUrl: link.faviconUrl!,
                      height: LmuIconSizes.mediumSmall,
                      width: LmuIconSizes.mediumSmall,
                      fit: BoxFit.cover,
                    ),
                  )
                : const LmuFaviconFallback(size: LmuIconSizes.mediumSmall),
          ),
          hasFavoriteStar: true,
          isFavorite: isFavorite,
          favoriteCount: link.rating.calculateLikeCount(isFavorite),
          onFavoriteTap: () async {
            GetIt.I<HomePreferencesService>().toggleLikedLinks(link.id);
            if (isFavorite) {
              LmuToast.show(
                context: context,
                type: ToastType.success,
                message: appLocals.favoriteRemoved,
                actionText: appLocals.undo,
                onActionPressed: () {
                  GetIt.I<HomePreferencesService>()
                      .toggleLikedLinks(link.id);
                },
              );
            } else {
              LmuToast.show(
                context: context,
                type: ToastType.success,
                message: appLocals.favoriteAdded,
              );
            }
            LmuVibrations.secondary();
          },
          onTap: () {
            if (additionalCallbackOnTap != null) {
              additionalCallbackOnTap!();
            }
            LmuUrlLauncher.launchWebsite(
              url: link.url,
              context: context,
              mode: LmuUrlLauncherMode.externalApplication,
            );

            GetIt.I<AnalyticsClient>().logClick(eventName: "link_clicked", parameters: {"link_title": link.title});
          },
          onLongPress: () => CopyToClipboardUtil.copyToClipboard(
            context: context,
            copiedText: link.url,
            message: context.locals.home.linkCopiedToClipboard,
          ),
        );
      },
    );
  }
}
