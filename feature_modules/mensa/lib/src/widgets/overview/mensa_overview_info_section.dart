import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../../repository/repository.dart';
import '../widgets.dart';

class MensaOverviewInfoSection extends StatelessWidget {
  const MensaOverviewInfoSection({
    super.key,
    required this.localizations,
  });

  final CanteenLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_48),
        const MensaTag(type: MensaType.mensa),
        const SizedBox(height: LmuSizes.size_8),
        LmuText.body(
          localizations.canteenInfo,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
        const SizedBox(height: LmuSizes.size_20),
        const MensaTag(type: MensaType.stuBistro),
        const SizedBox(height: LmuSizes.size_8),
        LmuText.body(
          localizations.bistroInfo,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
        const SizedBox(height: LmuSizes.size_20),
        const MensaTag(type: MensaType.stuCafe),
        const SizedBox(height: LmuSizes.size_8),
        LmuText.body(
          localizations.cafeInfo,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
        const SizedBox(height: LmuSizes.size_20),
        const MensaTag(type: MensaType.espressoBar),
        const SizedBox(height: LmuSizes.size_8),
        LmuText.body(
          localizations.espressoBarInfo,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
      ],
    );
  }
}
