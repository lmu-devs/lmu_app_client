import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../repository/api/models/menu/menu_item_model.dart';
import '../menu_item_tile.dart';

class MenuItemTileLoading extends StatelessWidget {
  const MenuItemTileLoading({super.key, this.hasLargeImage = false});

  final bool hasLargeImage;

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      context: context,
      child: MenuItemTile(
        menuItemModel: MenuItemModel.placeholder(
          title: BoneMock.words(7),
        ),
        isFavorite: false,
      ),
    );
  }
}
