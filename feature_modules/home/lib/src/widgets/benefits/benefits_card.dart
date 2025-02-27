import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../repository/api/models/benefits/benefit_model.dart';

class BenefitsCard extends StatelessWidget {
  const BenefitsCard({super.key, required this.benefit});

  final BenefitModel benefit;

  void _handleTap(BuildContext context) => LmuUrlLauncher.launchWebsite(
        url: benefit.url,
        context: context,
        mode: LmuUrlLauncherMode.externalApplication,
      );

  void _handleLongPress(BuildContext context) => CopyToClipboardUtil.copyToClipboard(
        context: context,
        copiedText: benefit.url,
        message: context.locals.home.linkCopiedToClipboard,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      onLongPress: () => _handleLongPress(context),
      child: LmuContentTile(
        padding: EdgeInsets.zero,
        content: [
          if (benefit.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(LmuRadiusSizes.medium),
                topRight: Radius.circular(LmuRadiusSizes.medium),
              ),
              child: LmuCachedNetworkImage(
                imageUrl: benefit.imageUrl!,
                height: LmuSizes.size_16 * 10,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          LmuListItem.base(
            title: benefit.title,
            subtitle: benefit.description,
            leadingArea: LmuCachedNetworkImage(
              imageUrl: benefit.faviconUrl,
              height: LmuIconSizes.medium,
              width: LmuIconSizes.medium,
            ),
            onTap: () => _handleTap(context),
            onLongPress: () => _handleLongPress(context),
          ),
        ],
      ),
    );
  }
}
