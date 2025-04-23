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
import 'dart:math' as math;

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
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.neutralColors.borderColors.seperatorLight,
                      offset: const Offset(0, 1),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                  ],
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
  const CompassIcon({super.key, this.size = 44.0});

  final double size;

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
            color: context.colors.neutralColors.borderColors.seperatorLight,
            offset: const Offset(0, 1),
            blurRadius: 1,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ValueListenableBuilder<String>(
            valueListenable: GetIt.I<ExploreMapService>().compassDirectionNotifier,
            builder: (context, direction, _) {
              return LmuText.bodySmall(direction);
            },
          ),
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
    final radius = size.width / 2 - 2;

    final weakTickPaint = Paint()
      ..color = context.colors.neutralColors.textColors.strongColors.disabled ??
          context.colors.neutralColors.textColors.weakColors.base
      ..style = PaintingStyle.fill;

    final mediumTickPaint = Paint()
      ..color = context.colors.neutralColors.textColors.mediumColors.base
      ..style = PaintingStyle.fill;

    final redTickPaint = Paint()
      ..color = context.colors.dangerColors.textColors.strongColors.pressed ??
          context.colors.dangerColors.textColors.strongColors.base
      ..style = PaintingStyle.fill;

    const triangleHeight = 6.5;
    const triangleBaseWidth = 1.25;

    final northPath = Path();
    northPath.moveTo(center.dx, center.dy - radius + 0.5);
    northPath.lineTo(center.dx - triangleBaseWidth * 2.5, center.dy - radius + triangleHeight + 1);
    northPath.lineTo(center.dx + triangleBaseWidth * 2.5, center.dy - radius + triangleHeight + 1);
    northPath.close();
    canvas.drawPath(northPath, redTickPaint);

    final eastPath = Path();
    eastPath.moveTo(center.dx + radius - 0.5, center.dy);
    eastPath.lineTo(center.dx + radius - triangleHeight - 1, center.dy - triangleBaseWidth);
    eastPath.lineTo(center.dx + radius - triangleHeight - 1, center.dy + triangleBaseWidth);
    eastPath.close();
    canvas.drawPath(eastPath, mediumTickPaint);

    final southPath = Path();
    southPath.moveTo(center.dx, center.dy + radius - 0.5);
    southPath.lineTo(center.dx - triangleBaseWidth, center.dy + radius - triangleHeight - 1);
    southPath.lineTo(center.dx + triangleBaseWidth, center.dy + radius - triangleHeight - 1);
    southPath.close();
    canvas.drawPath(southPath, mediumTickPaint);

    final westPath = Path();
    westPath.moveTo(center.dx - radius + 0.5, center.dy);
    westPath.lineTo(center.dx - radius + triangleHeight + 1, center.dy - triangleBaseWidth);
    westPath.lineTo(center.dx - radius + triangleHeight + 1, center.dy + triangleBaseWidth);
    westPath.close();
    canvas.drawPath(westPath, mediumTickPaint);

    final intermediateAngles = [30, 60, 120, 150, 210, 240, 300, 330];

    for (final angleDegrees in intermediateAngles) {
      final angleRadians = angleDegrees * (math.pi / 180);
      _drawIntermediateTick(canvas, center, radius, angleRadians, triangleHeight, triangleBaseWidth, weakTickPaint);
    }
  }

  void _drawIntermediateTick(Canvas canvas, Offset center, double radius, double angle, double triangleHeight,
      double triangleBaseWidth, Paint paint) {
    final tipX = center.dx + radius * math.cos(angle);
    final tipY = center.dy + radius * math.sin(angle);

    final dirX = math.cos(angle);
    final dirY = math.sin(angle);

    final perpX = -dirY;
    final perpY = dirX;

    final path = Path();
    path.moveTo(tipX - dirX * 0.5, tipY - dirY * 0.5);

    final baseX = tipX - dirX * (triangleHeight + 1);
    final baseY = tipY - dirY * (triangleHeight + 1);

    path.lineTo(baseX + perpX * triangleBaseWidth, baseY + perpY * triangleBaseWidth);
    path.lineTo(baseX - perpX * triangleBaseWidth, baseY - perpY * triangleBaseWidth);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
