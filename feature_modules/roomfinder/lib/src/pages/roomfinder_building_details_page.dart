import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../cubit/cubit.dart';
import '../repository/api/models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';

class RoomfinderBuildingDetailsPage extends StatefulWidget {
  const RoomfinderBuildingDetailsPage({super.key, required this.buildingId});

  final String buildingId;

  @override
  State<RoomfinderBuildingDetailsPage> createState() => _RoomfinderBuildingDetailsPageState();
}

class _RoomfinderBuildingDetailsPageState extends State<RoomfinderBuildingDetailsPage> {
  final buildingColor = const Color(0xFF39A6F9);

  late final List<RoomfinderFloor> _floors;
  late final RoomfinderBuilding _building;

  @override
  void initState() {
    super.initState();
    final roomfinderCubit = GetIt.I<RoomfinderCubit>();
    roomfinderCubit.state as RoomfinderLoadSuccess;
    if (roomfinderCubit.state is RoomfinderLoadSuccess) {
      final state = roomfinderCubit.state as RoomfinderLoadSuccess;
      _building = state.streets
          .expand((street) => street.buildings)
          .firstWhere((building) => building.buildingPartId == widget.buildingId);
      _floors = _building.floors;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        leadingAction: LeadingAction.back,
        largeTitle: _building.title,
        largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
        trailingWidgets: [_trailingAppBarAction],
        largeTitleTrailingWidget: LmuInTextVisual.text(
          title: context.locals.roomfinder.building,
          textColor: buildingColor,
          backgroundColor: buildingColor.withOpacity(0.14),
        ),
      ),
      slivers: [
        RoomfinderBuildingDetailsSection(building: _building),
        RoomfinderBuildingButtonSection(building: _building),
        RoomfinderBuildingFloorsSection(floors: _floors, building: _building),
      ],
    );
  }

  Widget get _trailingAppBarAction {
    final favoritesService = GetIt.I<RoomfinderFavoritesService>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
      child: ValueListenableBuilder(
        valueListenable: favoritesService.favoriteBuildingIdsNotifier,
        builder: (context, favoriteBuildings, _) {
          final isFavorite = favoriteBuildings.contains(_building.buildingPartId);
          return GestureDetector(
            onTap: () {
              favoritesService.toggleFavorite(_building.buildingPartId);
              LmuVibrations.secondary();
            },
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.size_4),
              child: Row(
                children: [
                  StarIcon(
                    isActive: isFavorite,
                    disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
