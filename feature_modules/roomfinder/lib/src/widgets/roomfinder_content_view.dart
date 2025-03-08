import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';

import '../repository/api/models/roomfinder_city.dart';
import '../routes/roomfinder_routes.dart';

class RoomfinderContentView extends StatefulWidget {
  const RoomfinderContentView({super.key, required this.cities});

  final List<RoomfinderCity> cities;

  @override
  State<RoomfinderContentView> createState() => _RoomfinderContentViewState();
}

class _RoomfinderContentViewState extends State<RoomfinderContentView> {
  late final LmuSearchController _searchController;
  late final List<LmuSearchInput> _searchInputs;

  @override
  void initState() {
    super.initState();

    _searchController = LmuSearchController();

    _searchController.addListener(() {});
    _searchInputs = [
      LmuSearchInput(
        title: "Search",
        id: "Search",
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final city in widget.cities) ...[
                  LmuText.h2(city.name),
                  const SizedBox(height: LmuSizes.size_12),
                  for (final street in city.streets) ...[
                    LmuTileHeadline.base(title: street.name),
                    LmuContentTile(
                      content: street.buildings.map((building) {
                        return LmuListItem.action(
                          title: building.title,
                          actionType: LmuListItemAction.chevron,
                          onTap: () => RoomfinderBuildingDetailsRoute(building).go(context),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: LmuSizes.size_32),
                  ],
                ],
                const SizedBox(height: 136),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: LmuSearchOverlay(
            searchController: _searchController,
            searchInputs: _searchInputs,
          ),
        ),
      ],
    );
  }
}
