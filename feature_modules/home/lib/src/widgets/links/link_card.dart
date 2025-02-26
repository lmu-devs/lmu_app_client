import 'package:core/components.dart';
import 'package:core/constants.dart';
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
  });

  final LinkModel link;

  @override
  Widget build(BuildContext context) {
    return LmuListItem.base(
      mainContentAlignment: MainContentAlignment.top,
      title: link.title,
      subtitle: link.description,
      leadingArea: LmuCachedNetworkImage(
        imageUrl: link.faviconUrl,
        height: LmuIconSizes.medium,
        width: LmuIconSizes.medium,
      ),
      trailingArea: ValueListenableBuilder<List<String>>(
        valueListenable: GetIt.I<HomePreferencesService>().likedLinksNotifier,
        builder: (context, likedLinkTitles, child) {
          return GestureDetector(
            onTap: () async {
              await GetIt.I<HomePreferencesService>().toggleLikedLinks(link.title);
              LmuVibrations.secondary();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: LmuSizes.size_4,
                left: LmuSizes.size_12,
                bottom: LmuSizes.size_12,
              ),
              child: StarIcon(isActive: likedLinkTitles.contains(link.title)),
            ),
          );
        },
      ),
      onTap: () => LmuUrlLauncher.launchWebsite(
        url: link.url,
        context: context,
        mode: LmuUrlLauncherMode.externalApplication,
      ),
      onLongPress: () => CopyToClipboardUtil.copyToClipboard(
        context: context,
        copiedText: link.url,
        message: context.locals.home.linkCopiedToClipboard,
      ),
    );
  }
}
