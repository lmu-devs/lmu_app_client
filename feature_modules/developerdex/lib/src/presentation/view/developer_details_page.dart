import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/model/animal.dart';
import '../../domain/model/lmu_developer.dart';
import '../../domain/model/rarity.dart';
import '../component/developer_blurred_image.dart';

class DeveloperDetailsPage extends StatelessWidget {
  const DeveloperDetailsPage({
    super.key,
    required this.developer,
  });

  final LmuDeveloper developer;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      customScrollController: context.modalScrollController,
      isBottomSheet: true,
      appBar: LmuAppBarData.custom(
        collapsedTitle: developer.name,
        leadingAction: LeadingAction.close,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            DeveloperBlurredImage(
              assetName: developer.animal.asset,
              size: MediaQuery.of(context).size.width * 0.6,
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuText.h1(
              developer.name,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuInTextVisual.text(
              title: developer.rarity.toLocalizedString(context.locals.developerdex),
              size: InTextVisualSize.large,
              backgroundColor: developer.rarity.toBackgroundColor(context.colors),
              textColor: developer.rarity.toTextColor(context.colors),
            ),
            const SizedBox(height: LmuSizes.size_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Wrap(
                spacing: LmuSizes.size_8,
                runSpacing: LmuSizes.size_8,
                alignment: WrapAlignment.center,
                children: developer.tags
                    .map(
                      (tag) => LmuInTextVisual.text(
                        title: tag,
                        size: InTextVisualSize.large,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
