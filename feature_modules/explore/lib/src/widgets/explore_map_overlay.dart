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
import '../widgets/explore_compass.dart';
import 'explore_map_dot.dart';

class ExploreMapOverlay extends StatelessWidget {
  const ExploreMapOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();
    final colors = context.colors;

    final locals = context.locals;
    return Padding(
      padding: const EdgeInsets.all(LmuSizes.size_8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //const ExploreAttribution(),
          Column(
            children: [
              MapCompass(
                alignment: Alignment.bottomRight,
                icon: Container(
                  //padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.neutralColors.backgroundColors.tile,
                  ),
                  child: const CompassIcon(),
                ),
                onPressed: () => mapService.faceNorth(),
                hideIfRotatedNorth: true,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: LmuSizes.size_8),
              Container(
                width: 44,
                height: 44,
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
                    mapService.focusUserLocation().then(
                      (value) {
                        if (!value) {
                          LmuToast.show(
                            context: context,
                            message: context.locals.explore.errorFocusUser,
                            type: ToastType.error,
                          );
                        }
                      },
                    );
                  },
                  child: ValueListenableBuilder<bool>(
                    valueListenable: mapService.isUserFocusedNotifier,
                    builder: (context, isUserLocationFocused, child) {
                      return LocationIcon(
                        size: LmuIconSizes.medium,
                        isFocused: isUserLocationFocused,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

class CompassIcon extends StatelessWidget {
  final double size;

  const CompassIcon({
    Key? key,
    this.size = 44.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer circle with triangular tick marks
          CustomPaint(
            size: Size(size, size),
            painter: CompassMarkerPainter(context: context),
          ),
        ],
      ),
    );
  }
}

class CompassMarkerPainter extends CustomPainter {
  CompassMarkerPainter({required this.context});

  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Draw the light gray ring
    final ringPaint = Paint()
      ..color = context.colors.neutralColors.backgroundColors.mediumColors.base
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius, ringPaint);

    // Draw the tick marks as triangles
    final tickPaint = Paint()
      ..color = context.colors.neutralColors.textColors.mediumColors.base
      ..style = PaintingStyle.fill;

    final redPaint = Paint()
      ..color = context.colors.dangerColors.backgroundColors.strongColors.active ??
          context.colors.dangerColors.backgroundColors.strongColors.base
      ..style = PaintingStyle.fill;

    // Calculate triangle dimensions
    const triangleHeight = 6.5;
    const triangleBaseWidth = 2.25;

    // North tick (top) - red triangle
    final northPath = Path();
    northPath.moveTo(center.dx, center.dy - radius + 1); // Tip
    northPath.lineTo(center.dx - triangleBaseWidth, center.dy - radius + triangleHeight + 1); // Left base
    northPath.lineTo(center.dx + triangleBaseWidth, center.dy - radius + triangleHeight + 1); // Right base
    northPath.close();
    canvas.drawPath(northPath, redPaint);

    // East tick (right) - black triangle
    final eastPath = Path();
    eastPath.moveTo(center.dx + radius - 1, center.dy); // Tip
    eastPath.lineTo(center.dx + radius - triangleHeight - 1, center.dy - triangleBaseWidth); // Top base
    eastPath.lineTo(center.dx + radius - triangleHeight - 1, center.dy + triangleBaseWidth); // Bottom base
    eastPath.close();
    canvas.drawPath(eastPath, tickPaint);

    // South tick (bottom) - black triangle
    final southPath = Path();
    southPath.moveTo(center.dx, center.dy + radius - 1); // Tip
    southPath.lineTo(center.dx - triangleBaseWidth, center.dy + radius - triangleHeight - 1); // Left base
    southPath.lineTo(center.dx + triangleBaseWidth, center.dy + radius - triangleHeight - 1); // Right base
    southPath.close();
    canvas.drawPath(southPath, tickPaint);

    // West tick (left) - black triangle
    final westPath = Path();
    westPath.moveTo(center.dx - radius + 1, center.dy); // Tip
    westPath.lineTo(center.dx - radius + triangleHeight + 1, center.dy - triangleBaseWidth); // Top base
    westPath.lineTo(center.dx - radius + triangleHeight + 1, center.dy + triangleBaseWidth); // Bottom base
    westPath.close();
    canvas.drawPath(westPath, tickPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
