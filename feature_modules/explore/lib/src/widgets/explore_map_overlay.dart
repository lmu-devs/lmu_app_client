import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../extensions/explore_marker_type_extension.dart';
import '../routes/explore_routes.dart';
import '../services/explore_map_service.dart';
import 'explore_attribution.dart';
import 'explore_map_dot.dart';

class ExploreMapOverlay extends StatelessWidget {
  const ExploreMapOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();
    final colors = context.colors;

    final locals = context.locals;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(LmuSizes.size_8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ExploreAttribution(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.neutralColors.backgroundColors.tile,
                  borderRadius: BorderRadius.circular(LmuSizes.size_8),
                  border: Border.all(
                    color: context.colors.neutralColors.borderColors.seperatorLight,
                    width: 1,
                  ),
                ),
                child: GestureDetector(
                  onTap: () async {
                    await PermissionsService.isLocationPermissionGranted().then(
                      (isPermissionGranted) async {
                        if (!isPermissionGranted) {
                          await PermissionsService.showLocationPermissionDeniedDialog(context);
                          return;
                        }
                        await PermissionsService.isLocationServicesEnabled().then(
                          (isLocationServicesEnabled) async {
                            if (!isLocationServicesEnabled) {
                              await PermissionsService.showLocationServiceDisabledDialog(context);
                              return;
                            }
                          },
                        );
                      },
                    );
                    mapService.focuUserLocation();
                  },
                  child: const LmuIcon(
                    icon: LucideIcons.navigation,
                    size: LmuIconSizes.medium,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.base,
            border: Border(
              top: BorderSide(
                color: context.colors.neutralColors.borderColors.seperatorLight,
                width: 1,
              ),
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: mapService.exploreLocationFilterNotifier,
            builder: (context, activeFilters, child) {
              return LmuButtonRow(
                buttons: [
                  LmuButton(
                    title: context.locals.app.search,
                    leadingIcon: LucideIcons.search,
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () => const ExploreSearchRoute().go(context),
                  ),
                  ...ExploreLocationFilter.values.map(
                    (val) {
                      final isActive = activeFilters.contains(val);
                      return LmuButton(
                        leadingWidget: _getIconWidget(context.colors, val),
                        title: _labelForFilter(locals, val),
                        emphasis: isActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                        action: isActive ? ButtonAction.contrast : ButtonAction.base,
                        onTap: () => mapService.updateFilter(val),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  String _labelForFilter(LmuLocalizations locals, ExploreLocationFilter filter) {
    switch (filter) {
      case ExploreLocationFilter.mensa:
        return locals.canteen.canteens;
      case ExploreLocationFilter.building:
        return locals.roomfinder.buildings;
      case ExploreLocationFilter.cinema:
        return locals.cinema.cinemasTitle;
    }
  }

  Widget? _getIconWidget(LmuColors colors, ExploreLocationFilter filter) {
    final exploreMarkerTypes = () {
      if (filter == ExploreLocationFilter.building) {
        return [
          ExploreMarkerType.roomfinderRoom,
        ];
      } else if (filter == ExploreLocationFilter.mensa) {
        return [
          ExploreMarkerType.mensaMensa,
          ExploreMarkerType.mensaStuBistro,
          ExploreMarkerType.mensaStuCafe,
          ExploreMarkerType.mensaStuLounge,
        ];
      } else if (filter == ExploreLocationFilter.cinema) {
        return [
          ExploreMarkerType.cinema,
        ];
      }
    }();

    if (exploreMarkerTypes?.isEmpty ?? true) {
      return null;
    }

    return Stack(
      children: exploreMarkerTypes!
          .mapIndexed(
            (index, marker) => Padding(
              padding: EdgeInsets.only(
                left: index * 8.0,
              ),
              child: ExploreMapDot(
                dotColor: marker.markerColor(colors),
                icon: marker.icon,
                markerSize: ExploreMarkerSize.large,
              ),
            ),
          )
          .toList(),
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
