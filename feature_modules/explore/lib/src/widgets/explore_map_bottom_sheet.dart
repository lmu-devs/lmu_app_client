import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../extensions/explore_marker_type_extension.dart';
import '../routes/explore_routes.dart';
import '../services/explore_map_service.dart';

class ExploreMapBottomSheet extends StatelessWidget {
  const ExploreMapBottomSheet({super.key, required this.selectedLocation});

  final ExploreLocation selectedLocation;

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();
    final colors = context.colors;
    final locals = context.locals;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  LmuText.h1(selectedLocation.name),
                  LmuInTextVisual.text(
                    title: selectedLocation.type.localizedName(locals),
                    textColor: selectedLocation.type.markerColor(colors),
                    backgroundColor: selectedLocation.type.markerColor(colors).withOpacity(0.14),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                mapService.deselectMarker();
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(LmuSizes.size_4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                ),
                child: const LmuIcon(
                  icon: LucideIcons.x,
                  size: LmuIconSizes.medium,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuListItem.base(
          subtitle: selectedLocation.address,
          trailingArea: Icon(
            LucideIcons.map,
            size: LmuIconSizes.mediumSmall,
            color: colors.neutralColors.textColors.weakColors.base,
          ),
          hasHorizontalPadding: false,
          hasDivider: true,
          onTap: () {
            LmuBottomSheet.show(
              context,
              content: NavigationSheet(
                latitude: selectedLocation.latitude,
                longitude: selectedLocation.longitude,
                address: selectedLocation.address,
              ),
            );
          },
        ),
        const SizedBox(height: LmuSizes.size_16),
        LmuContentTile(
          content: LmuListItem.action(
            title: "Show ${selectedLocation.type.localizedName(locals)}",
            actionType: LmuListItemAction.chevron,
            onTap: () {
              final id = selectedLocation.id;
              final exploreType = selectedLocation.type;
              switch (exploreType) {
                case ExploreMarkerType.mensaMensa:
                case ExploreMarkerType.mensaStuBistro:
                case ExploreMarkerType.mensaStuCafe:
                case ExploreMarkerType.mensaStuLounge:
                  ExploreMensaRoute(id).go(context);
                  break;
                case ExploreMarkerType.cinema:
                  ExploreCinemaRoute(id).go(context);
                  break;
                case ExploreMarkerType.roomfinderRoom:
                  ExploreBuildingRoute(id).go(context);
                  break;
              }
            },
          ),
        ),
      ],
    );
  }
}
