import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/explore_map_service.dart';
import 'explore_action_row.dart';
import 'explore_attribution.dart';
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

// class _LayerBottomSheetContent extends StatelessWidget {
//   const _LayerBottomSheetContent();

//   @override
//   Widget build(BuildContext context) {
//     const filters = ExploreLocationFilter.values;
//     final mapService = GetIt.I<ExploreMapService>();

//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           LmuText.h1('Choose Filter'),
//           const SizedBox(height: 16),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: filters.length,
//             padding: EdgeInsets.zero,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 1.5,
//             ),
//             itemBuilder: (context, index) {
//               final filter = filters[index];

//               return GestureDetector(
//                 onTap: () {
//                   mapService.updateFilter(filter);
//                 },
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
//                   child: Stack(
//                     children: [
//                       Container(
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: AssetImage(
//                               'assets/explore_layer_example.png',
//                               package: "explore",
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           color: context.colors.neutralColors.backgroundColors.tile.withOpacity(0.9),
//                           padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_12, vertical: LmuSizes.size_8),
//                           child: LmuText.body(
//                             _labelForFilter(context.locals, filter),
//                             weight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                       ValueListenableBuilder(
//                         valueListenable: mapService.exploreLocationFilterNotifier,
//                         builder: (context, selectedFilter, child) {
//                           final isSelected = selectedFilter == filter;

//                           return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
//                               border: isSelected
//                                   ? Border.all(
//                                       color: context.colors.brandColors.textColors.strongColors.base,
//                                       width: 3,
//                                     )
//                                   : null,
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
