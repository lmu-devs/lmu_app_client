import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../links/favorite_link_row_loading.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<(int, int)> loadingTileSizes = [(2, 1), (1, 1), (1, 1), (1, 1), (1, 1), (2, 2), (1, 1), (1, 1)];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FavoriteLinkRowLoading(),
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: LmuSizes.size_16,
              crossAxisSpacing: LmuSizes.size_16,
              children: loadingTileSizes.map(
                (tile) {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: tile.$1,
                    mainAxisCellCount: tile.$2,
                    child: const LmuFeatureTileLoading(),
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }
}
