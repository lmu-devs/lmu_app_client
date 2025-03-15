import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../repository/api/models/models.dart';
import '../routes/roomfinder_routes.dart';

enum RoomfinderSortOption {
  distance,
  alphabetically,
}

class RoomfinderContentView extends StatefulWidget {
  const RoomfinderContentView({super.key, required this.cities});

  final List<RoomfinderCity> cities;

  @override
  State<RoomfinderContentView> createState() => _RoomfinderContentViewState();
}

class _RoomfinderContentViewState extends State<RoomfinderContentView> {
  late final LmuSearchController _searchController;
  late final List<LmuSearchInput> _searchInputs;

  late final List<RoomfinderStreet> _streets;

  @override
  void initState() {
    super.initState();

    _searchController = LmuSearchController();

    _streets = widget.cities.expand((city) => city.streets).toList();
    _streets.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

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
                SizedBox(
                  height: LmuSizes.size_24,
                  child: StarIcon(
                    isActive: false,
                    size: LmuIconSizes.small,
                    disabledColor: context.colors.neutralColors.textColors.weakColors.base,
                  ),
                ),
                const SizedBox(height: LmuSizes.size_12),
                LmuContentTile(
                  content: LmuListItem.action(
                    title: _streets.first.buildings.first.title,
                    actionType: LmuListItemAction.chevron,
                    onTap: () => RoomfinderBuildingDetailsRoute(_streets.first.buildings.first).go(context),
                  ),
                ),
                const SizedBox(height: LmuSizes.size_32),
                LmuTileHeadline.base(title: "Alle Gebäude"),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => GetIt.I.get<ExploreService>().navigateToExplore(context),
                      child: Container(
                        height: LmuActionSizes.base,
                        width: LmuActionSizes.base,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
                          border: Border.all(
                            color: context.colors.neutralColors.borderColors.seperatorLight,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: LmuSizes.size_8),
                    LmuButton(
                      title: "Distance",
                      emphasis: ButtonEmphasis.secondary,
                      trailingIcon: LucideIcons.chevron_down,
                      onTap: () {
                        LmuBottomSheet.show(
                          context,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: RoomfinderSortOption.values
                                .mapIndexed(
                                  (index, option) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            (index == RoomfinderSortOption.values.length - 1) ? 0 : LmuSizes.size_8),
                                    child: LmuListItem.base(
                                      title: option.name,
                                      onTap: () {},
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: LmuSizes.size_24),
                ListView.separated(
                  itemCount: _streets.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 120),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, index) => const SizedBox(height: LmuSizes.size_12),
                  itemBuilder: (_, index) {
                    final street = _streets[index];
                    final sortedBuildings = street.buildings.toList()
                      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
                    return LmuContentTile(
                      key: Key(street.id),
                      content: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sortedBuildings.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final building = sortedBuildings[index];
                          return LmuListItem.action(
                            key: Key(building.id),
                            title: building.title,
                            actionType: LmuListItemAction.chevron,
                            onTap: () => RoomfinderBuildingDetailsRoute(building).go(context),
                          );
                        },
                      ),
                    );
                  },
                ),
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
