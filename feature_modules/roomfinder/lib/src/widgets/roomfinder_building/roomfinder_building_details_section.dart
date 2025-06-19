import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../repository/api/models/models.dart';

class RoomfinderBuildingDetailsSection extends StatelessWidget {
  const RoomfinderBuildingDetailsSection({
    super.key,
    required RoomfinderBuilding building,
  }) : _building = building;

  final RoomfinderBuilding _building;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: LmuSizes.size_16),
              child: LmuListItem.base(
                subtitle: _building.location.address,
                trailingArea: Icon(
                  LucideIcons.map,
                  size: LmuIconSizes.mediumSmall,
                  color: context.colors.neutralColors.textColors.weakColors.base,
                ),
                hasHorizontalPadding: false,
                hasDivider: true,
                onTap: () {
                  LmuBottomSheet.show(
                    context,
                    content: NavigationSheet(locationId: _building.buildingPartId, location: _building.location),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
