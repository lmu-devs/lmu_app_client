import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:core/components.dart';

import '../dish_tile.dart';

class DishTileLoading extends StatelessWidget {
  const DishTileLoading({super.key, this.hasLargeImage = false});

  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      context: context,
      child: DishTile(
        dishType: "E",
        title: BoneMock.words(7),
        priceSimple: "€€€",
        isLiked: false,
        likeCount: 0,
        onFavoriteTap: () {},
      ),
    );
  }
}