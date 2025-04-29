import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../themes.dart';

class LmuFavoriteButton extends StatelessWidget {
  const LmuFavoriteButton({
    super.key,
    required this.isFavorite,
    this.calculatedLikes,
    required this.onTap,
  });

  final bool isFavorite;
  final String? calculatedLikes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
        LmuVibrations.secondary();
      },
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_8),
        child: Row(
          children: [
            if (calculatedLikes != null) ...[
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 10),
                child: LmuText.bodySmall(calculatedLikes),
              ),
              const SizedBox(width: LmuSizes.size_4),
            ],
            StarIcon(
              isActive: isFavorite,
              disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
            ),
          ],
        ),
      ),
    );
  }
}
