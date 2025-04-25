import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/explore_map_service.dart';
import 'explore_action_row.dart';
import '../widgets/explore_compass.dart';
import 'explore_location_button.dart';

class ExploreMapOverlay extends StatelessWidget {
  const ExploreMapOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(LmuSizes.size_8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //const ExploreAttribution(),
              Column(
                children: [
                  ExploreCompass(onPressed: () => mapService.faceNorth()),
                  const SizedBox(height: LmuSizes.size_8),
                  const ExploreLocationButton(),
                ],
              ),
            ],
          ),
        ),
        const ExploreActionRow(),
      ],
    );
  }
}
