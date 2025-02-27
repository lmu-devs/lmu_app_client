import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../repository/api/models/benefits/benefit_model.dart';

class BenefitsContentView extends StatelessWidget {
  const BenefitsContentView({
    super.key,
    required this.benefits,
  });

  final List<BenefitModel> benefits;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: LmuSizes.size_16,
        right: LmuSizes.size_16,
        bottom: LmuSizes.size_96,
      ),
      child: Column(
        children: benefits.map((benefit) {
          return Column(
            children: [
              GestureDetector(
                onTap: () => LmuUrlLauncher.launchWebsite(
                  url: benefit.url,
                  context: context,
                  mode: LmuUrlLauncherMode.externalApplication,
                ),
                onLongPress: () => CopyToClipboardUtil.copyToClipboard(
                  context: context,
                  copiedText: benefit.url,
                  message: context.locals.home.linkCopiedToClipboard,
                ),
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}
