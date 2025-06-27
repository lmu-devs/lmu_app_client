import 'package:flutter/material.dart';

import '../../constants/lmu_sizes.dart';
import 'lmu_text_badge.dart';

class LmuPaddedTextBadge extends StatelessWidget {
  const LmuPaddedTextBadge({
    required this.inTextVisuals,
    this.noPaddingOnFirstElement = false,
    this.hasPaddingOnRight = false,
    super.key,
  });

  final List<LmuTextBadge> inTextVisuals;
  final bool noPaddingOnFirstElement;
  final bool hasPaddingOnRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: inTextVisuals.asMap().entries.map((entry) {
        final index = entry.key;
        final visual = entry.value;
        final isFirst = index == 0;
        final noPadding = noPaddingOnFirstElement && isFirst;
        final padding = EdgeInsets.only(
          left: !hasPaddingOnRight ? (noPadding ? LmuSizes.none : LmuSizes.size_4) : LmuSizes.none,
          right: hasPaddingOnRight ? (noPadding ? LmuSizes.none : LmuSizes.size_4) : LmuSizes.none,
        );

        return Padding(
          padding: padding,
          child: visual,
        );
      }).toList(),
    );
  }
}
