import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class MenuCafeBarView extends StatelessWidget {
  const MenuCafeBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: LmuSizes.size_8,
        horizontal: LmuSizes.size_16,
      ),
      child: Column(
        children: [
          Wrap(
            spacing: LmuSizes.size_8,
            children: [
              Icon(
                LucideIcons.coffee,
                size: LmuIconSizes.large,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
              Icon(
                LucideIcons.croissant,
                size: LmuIconSizes.large,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              )
            ],
          ),
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: LmuText.body(
              context.locals.canteen.cafeBarInfo,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
