import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/models/club.dart';

class ClubLinksSection extends StatelessWidget {
  const ClubLinksSection({super.key, required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    final links = <Widget>[];

    if (club.url != null && club.url!.isNotEmpty) {
      links.add(
        LmuListItem.action(
          title: context.locals.clubs.website,
          actionType: LmuListItemAction.chevron,
          onTap: () => LmuUrlLauncher.launchWebsite(
            context: context,
            url: club.url!,
            mode: LmuUrlLauncherMode.externalApplication,
          ),
        ),
      );
    }

    if (club.email != null && club.email!.isNotEmpty) {
      links.add(
        LmuListItem.action(
          title: context.locals.clubs.email,
          actionType: LmuListItemAction.chevron,
          onTap: () => LmuUrlLauncher.launchWebsite(
            context: context,
            url: 'mailto:${club.email!}',
            mode: LmuUrlLauncherMode.externalApplication,
          ),
        ),
      );
    }

    if (links.isEmpty) return const SizedBox.shrink();

    return LmuContentTile(
      contentList: links,
    );
  }
}
