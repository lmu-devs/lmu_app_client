import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../favicon_fallback.dart';

class LinkCardLoading extends StatelessWidget {
  const LinkCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuListItem.base(
      mainContentAlignment: MainContentAlignment.top,
      title: BoneMock.words(2),
      subtitle: BoneMock.words(4),
      leadingArea: const FaviconFallback(size: LmuIconSizes.mediumSmall),
      trailingArea: StarIcon(),
    );
  }
}
