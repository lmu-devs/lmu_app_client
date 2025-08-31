import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core_routes/explore.dart';
import 'package:core_routes/roomfinder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../../repository/api/models/models.dart';
import '../../services/roomfinder_room_search_service.dart';

class RoomfinderBuildingButtonSection extends StatelessWidget {
  const RoomfinderBuildingButtonSection({
    super.key,
    required this.building,
    this.withMapButton = true,
  });

  final RoomfinderBuilding building;
  final bool withMapButton;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: LmuSizes.size_16),
        child: LmuButtonRow(
          buttons: [
            if (withMapButton)
              LmuMapImageButton(
                  onTap: () {
                    const ExploreMainRoute().go(context);
                    GetIt.I<ExploreApi>().selectLocation(building.buildingPartId);
                  },
              ),
            LmuIconButton(
              icon: LucideIcons.search,
              onPressed: () async {
                if (GetIt.I.isRegistered<RoomfinderRoomSearchService>()) {
                  GetIt.I.unregister<RoomfinderRoomSearchService>();
                }

                final instance = RoomfinderRoomSearchService(
                  buildingPartId: building.buildingPartId,
                  buildingId: building.id,
                );
                GetIt.I.registerSingleton<RoomfinderRoomSearchService>(instance);
                await instance.init();
                if (context.mounted) {
                  RoomfinderRoomSearchRoute(building.buildingPartId).push(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
