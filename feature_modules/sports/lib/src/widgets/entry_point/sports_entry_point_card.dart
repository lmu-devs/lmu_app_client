import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class SportsEntryPointCard extends StatelessWidget {
  const SportsEntryPointCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final sportsLocals = context.locals.sports;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LmuSizes.size_12),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://www.adh.de/fileadmin/user_upload/adh.de/bilder/Newsbilder_2020/3_Adventskalender_neu_ZHS_Muenchen.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(LmuSizes.size_12),
                    bottomRight: Radius.circular(LmuSizes.size_12),
                  ),
                  color: context.colors.neutralColors.backgroundColors.pure.withOpacity(0.8),
                ),
                child: LmuListItem.base(
                  title: sportsLocals.sportsTitle,
                  subtitle: '523 ${sportsLocals.sportOffers}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
