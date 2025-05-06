import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/models/benefit.dart';

class BenefitCard extends StatelessWidget {
  const BenefitCard({super.key, required this.benefit});

  final Benefit benefit;

  void _handleTap(BuildContext context) => LmuUrlLauncher.launchWebsite(
        context: context,
        url: benefit.url,
        mode: LmuUrlLauncherMode.externalApplication,
      );

  void _handleLongPress(BuildContext context) => CopyToClipboardUtil.copyToClipboard(
        context: context,
        copiedText: benefit.url,
        message: context.locals.home.linkCopiedToClipboard,
      );

  String? get imageUrl => benefit.imageUrl;
  String? get faviconUrl => benefit.faviconUrl;

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: benefit.title,
      subtitle: benefit.description,
      imageUrl: benefit.imageUrl,
      hasLargeImage: benefit.imageUrl != null && benefit.imageUrl!.isNotEmpty,
      leadingIcon: benefit.faviconUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(LmuRadiusSizes.xsmall),
              child: LmuCachedNetworkImage(
                imageUrl: benefit.faviconUrl!,
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
