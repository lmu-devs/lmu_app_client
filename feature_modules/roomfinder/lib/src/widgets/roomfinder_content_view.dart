import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';

import 'roomfinder_button_section.dart';
import 'roomfinder_favorites_section.dart';
import 'roomfinder_filtered_buildings_section.dart';
import 'roomfinder_search_overlay.dart';

class RoomfinderContentView extends StatelessWidget {
  const RoomfinderContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoomfinderFavoritesSection(),
                RoomfinderButtonSection(),
                RoomfinderFilteredBuildingsSection(),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: RoomfinderSearchOverlay(),
        ),
      ],
    );
  }
}
