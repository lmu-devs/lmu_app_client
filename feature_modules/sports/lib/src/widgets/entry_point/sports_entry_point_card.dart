import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../../../sports.dart';

class SportsEntryPointCard extends StatelessWidget {
  const SportsEntryPointCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: GestureDetector(
        onTap: () => const SportsMainRoute().go(context),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LmuSizes.size_12),
                color: context.colors.neutralColors.backgroundColors.tile,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(LmuSizes.size_12),
                  bottomRight: Radius.circular(LmuSizes.size_12),
                ),
                color: context.colors.neutralColors.backgroundColors.mediumColors.base,
              ),
              child: LmuListItem.base(
                title: 'Sport',
                subtitle: '123 Sportangebote',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
