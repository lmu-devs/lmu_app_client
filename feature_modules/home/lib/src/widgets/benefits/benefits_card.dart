import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../repository/api/models/benefits/benefit_model.dart';
import '../favicon_fallback.dart';

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
        contentList: [
          if (benefit.imageUrl != null)
            Container(
              height: LmuSizes.size_16 * 10,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(LmuRadiusSizes.mediumLarge),
                  topRight: Radius.circular(LmuRadiusSizes.mediumLarge),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: LmuCachedNetworkImageProvider(benefit.imageUrl!),
                ),
              ),
            ),
          LmuListItem.base(
            title: benefit.title,
            subtitle: benefit.description,
            leadingArea: benefit.faviconUrl != null && benefit.faviconUrl!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(LmuRadiusSizes.xsmall),
                    child: LmuCachedNetworkImage(
                      imageUrl: benefit.faviconUrl!,
                      height: LmuIconSizes.mediumSmall,
                      width: LmuIconSizes.mediumSmall,
                      fit: BoxFit.cover,
                    ),
                  )
                : const FaviconFallback(size: LmuIconSizes.mediumSmall),
            onTap: () => _handleTap(context),
            onLongPress: () => _handleLongPress(context),
          ),
        ],
      ),
    );
  }
}
