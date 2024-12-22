import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class TasteProfileTitleSection extends StatelessWidget {
  const TasteProfileTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_8),
          LmuText.body(
            context.locals.canteen.myTasteDescription,
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }
}
