import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../widgets/widgets.dart';

class MensaLoadingView extends StatelessWidget {
  const MensaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: LmuSizes.mediumLarge,
          vertical: LmuSizes.mediumLarge,
        ),
        child: Column(
          children: [
            LmuTileHeadline.base(
              title: context.localizations.favorites,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const MensaOverviewTileLoading();
              },
            ),
            const SizedBox(height: LmuSizes.xxlarge),
            LmuTileHeadline.base(
              title: context.localizations.allCanteens,
            ),
            Row(
              children: [
                LmuButton(
                  title: context.localizations.alphabetically,
                  emphasis: ButtonEmphasis.secondary,
                  state: ButtonState.disabled,
                  trailingIcon: LucideIcons.chevron_down,
                ),
                const SizedBox(width: LmuSizes.mediumSmall),
                LmuButton(
                  title: context.localizations.openNow,
                  emphasis: ButtonEmphasis.secondary,
                  state: ButtonState.disabled,
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.mediumLarge),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const MensaOverviewTileLoading(
                  hasLargeImage: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
