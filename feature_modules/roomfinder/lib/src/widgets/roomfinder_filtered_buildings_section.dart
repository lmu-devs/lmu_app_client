import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../routes/roomfinder_routes.dart';
import '../services/roomfinder_building_view_item.dart';
import '../services/roomfinder_filter_service.dart';

class RoomfinderFilteredBuildingsSection extends StatefulWidget {
  const RoomfinderFilteredBuildingsSection({super.key});

  @override
  State<RoomfinderFilteredBuildingsSection> createState() => _RoomfinderFilteredBuildingsSectionState();
}

class _RoomfinderFilteredBuildingsSectionState extends State<RoomfinderFilteredBuildingsSection> {
  final _filterService = GetIt.I.get<RoomfinderFilterService>();

  late final ValueNotifier<List<List<RoomfinderBuildingViewItem>>> _filteredBuildingsNotifier;

  @override
  void initState() {
    super.initState();
    _filteredBuildingsNotifier = _filterService.filteredBuildingsNotifier;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _filteredBuildingsNotifier,
      builder: (context, filteredBuildings, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: ListView.separated(
            key: ValueKey(filteredBuildings.expand((element) => element).map((e) => e.id).join()),
            itemCount: filteredBuildings.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: LmuSizes.size_96),
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, index) => const SizedBox(height: LmuSizes.size_16),
            itemBuilder: (_, index) {
              final buildings = filteredBuildings[index];
              return LmuContentTile(
                key: Key(buildings.first.id),
                content: Column(
                  children: buildings.map(
                    (building) {
                      return LmuListItem.action(
                        key: Key(building.id),
                        title: building.title,
                        trailingTitle: building.distance?.formatDistance(),
                        actionType: LmuListItemAction.chevron,
                        onTap: () => RoomfinderBuildingDetailsRoute(building.id).go(context),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
