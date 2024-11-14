import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:core/components.dart';

import '../../repository/api/models/dish_model.dart';
import '../../repository/api/models/rating_model.dart';
import '../dish_tile.dart';

class DishTileLoading extends StatelessWidget {
  const DishTileLoading({super.key, this.hasLargeImage = false});

  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
        context: context,
        child: DishTile(
          dishModel: DishModel(
            id: 1,
            name: BoneMock.words(3),
            labels: const [],
            prices: const [],
            ratingModel: const RatingModel(likeCount: 0, isLiked: false),
            dishType: "E",
            priceSimple: "€€€",
          ),
          onFavoriteTap: () {},
        ));
  }
}
