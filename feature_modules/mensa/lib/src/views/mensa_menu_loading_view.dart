import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/loading/dish_tile_loading.dart';

class MensaMenuLoadingView extends StatelessWidget {
  const MensaMenuLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(LmuSizes.mediumLarge),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: LmuSizes.mediumSmall),
          child: LmuSkeleton(
            context: context,
            child: const DishTileLoading(),
          ),
        );
      },
    );
  }
}
