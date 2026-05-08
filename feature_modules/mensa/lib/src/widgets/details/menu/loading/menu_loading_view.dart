import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'menu_item_tile_loading.dart';

class MenuLoadingView extends StatelessWidget {
  const MenuLoadingView({super.key, required this.canteendId});

  final String canteendId;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: const LmuTabBarLoading(
        hasDivider: true,
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(
          top: LmuSizes.size_24,
          left: LmuSizes.size_16,
          right: LmuSizes.size_16,
        ),
        sliver: SliverList.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            if (index == 0) return const LmuTileHeadlineLoading();

            return const MenuItemTileLoading();
          },
        ),
      ),
    );
  }
}
