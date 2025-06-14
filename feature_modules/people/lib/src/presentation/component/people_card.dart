import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/model/people.dart';

class PeopleCard extends StatelessWidget {
  const PeopleCard({super.key, required this.people});

  final People people;

  void _handleTap(BuildContext context) => LmuUrlLauncher.launchWebsite(
        context: context,
        url: people.url,
        mode: LmuUrlLauncherMode.externalApplication,
      );

  void _handleLongPress(BuildContext context) => CopyToClipboardUtil.copyToClipboard(
        context: context,
        copiedText: people.url,
        message: context.locals.home.linkCopiedToClipboard,
      );

  String? get faviconUrl => people.faviconUrl;

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: people.name,
      subtitle: people.description,
      leadingIcon: people.faviconUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(LmuRadiusSizes.xsmall),
              child: LmuCachedNetworkImage(
                imageUrl: people.faviconUrl!,
                height: LmuIconSizes.mediumSmall,
                width: LmuIconSizes.mediumSmall,
                fit: BoxFit.cover,
              ),
            )
          : const LmuFaviconFallback(size: LmuIconSizes.mediumSmall),
      onTap: () => _handleTap(context),
      onLongPress: () => _handleLongPress(context),
    );
  }
}
