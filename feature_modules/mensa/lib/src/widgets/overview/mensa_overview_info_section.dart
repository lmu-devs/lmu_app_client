import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/mensa.dart';

import '../widgets.dart';

class MensaOverviewInfoSection extends StatelessWidget {
  const MensaOverviewInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final canteenLocals = context.locals.canteen;

    final Map<MensaType, String> typeInfoMapping = {
      MensaType.mensa: canteenLocals.canteenInfo,
      MensaType.stuBistro: canteenLocals.bistroInfo,
      MensaType.stuCafe: canteenLocals.cafeInfo,
      MensaType.cafeBar: canteenLocals.cafeBarInfo,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_32),
        for (final type in typeInfoMapping.keys)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: LmuSizes.size_20),
              MensaTag(type: type),
              const SizedBox(height: LmuSizes.size_8),
              LmuText.body(
                typeInfoMapping[type]!,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
            ],
          ),
      ],
    );
  }
}
