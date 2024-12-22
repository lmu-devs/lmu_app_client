import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class TasteProfileFooterSection extends StatelessWidget {
  const TasteProfileFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.size_48),
          LmuText.bodyXSmall(
            context.locals.canteen.myTasteFooter,
            color: context.colors.neutralColors.textColors.weakColors.base,
          ),
          const SizedBox(height: LmuSizes.size_64),
        ],
      ),
    );
  }
}
