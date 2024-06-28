import 'dart:math';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../repository/api/api.dart';
import 'mensa_tag.dart';

class MensaOverviewTile extends StatelessWidget {
  const MensaOverviewTile({
    super.key,
    required this.title,
    required this.type,
    required this.status,
    required this.isFavorite,
    required this.onFavoriteTap,
    this.distance,
    this.onTap,
  });

  final String title;
  final double? distance;
  final MensaType type;
  final MensaStatus status;
  final void Function()? onTap;
  final bool isFavorite;
  final void Function()? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuSizes.medium),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(
          LmuSizes.mediumLarge,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: LmuText.h3(
                          title,
                        ),
                      ),
                      const SizedBox(
                        width: LmuSizes.mediumSmall,
                      ),
                      MensaTag(
                        type: type,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: LmuSizes.mediumSmall,
                ),
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: isFavorite
                      ? const LmuIcon(
                          icon: Icons.star,
                          size: LmuIconSizes.medium,
                          color: Color.fromARGB(255, 247, 209, 21),
                        )
                      : LmuIcon(
                          icon: Icons.star_border_outlined,
                          size: LmuIconSizes.medium,
                          color: context.colors.neutralColors.backgroundColors.flippedColors.base,
                        ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LmuText.body(
                  status.name,
                  color: status.textColor(context),
                ),
                LmuText.body(
                  " • ",
                ),
                LmuText.body(
                  distanceString,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String get distanceString {
    final randomDistance = _getRandomDoubleInRange(0.1, 15.0);
    return '$randomDistance km';
  }

  double _getRandomDoubleInRange(double min, double max) {
    Random random = Random();
    double randomDouble = min + (max - min) * random.nextDouble();
    return double.parse(randomDouble.toStringAsFixed(1));
  }
}

extension MensaStatusExtension on MensaStatus {
  Color textColor(BuildContext context) {
    switch (this) {
      case MensaStatus.open:
        return Colors.green;
      case MensaStatus.closed:
        return Colors.red;
      case MensaStatus.closingSoon:
        return Colors.orange;
    }
  }
}
