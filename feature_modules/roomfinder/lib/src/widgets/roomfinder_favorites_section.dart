import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/roomfinder.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../services/roomfinder_building_view_item.dart';
import '../services/roomfinder_favorites_service.dart';
import '../services/roomfinder_filter_service.dart';

class RoomfinderFavoritesSection extends StatefulWidget {
  const RoomfinderFavoritesSection({super.key});

  @override
  State<RoomfinderFavoritesSection> createState() => _RoomfinderFavoritesSectionState();
}

class _RoomfinderFavoritesSectionState extends State<RoomfinderFavoritesSection> {
  final _roomfinderFavoritesService = GetIt.I.get<RoomfinderFavoritesService>();
  final _roomfinderFilterService = GetIt.I.get<RoomfinderFilterService>();

  late ValueNotifier<List<String>> _favoriteBuildingIdsNotifier;
  late ValueNotifier<List<RoomfinderBuildingViewItem>> _buildingsNotifier;

  @override
  void initState() {
    super.initState();
    _favoriteBuildingIdsNotifier = _roomfinderFavoritesService.favoriteBuildingIdsNotifier;
    final availableBuildings =
        _roomfinderFilterService.filteredBuildingsNotifier.value.expand((group) => group).toList();
    _buildingsNotifier = ValueNotifier(availableBuildings);
  }

  @override
  Widget build(BuildContext context) {
    final locals = context.locals;
    final placeholderTextColor = context.colors.neutralColors.textColors.mediumColors.base;
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        SizedBox(
          height: LmuSizes.size_24,
          child: StarIcon(
            isActive: false,
            size: LmuIconSizes.small,
            disabledColor: context.colors.neutralColors.textColors.weakColors.base,
          ),
        ),
        const SizedBox(height: LmuSizes.size_12),
        ValueListenableBuilder(
          valueListenable: _favoriteBuildingIdsNotifier,
          builder: (context, favoriteBuildingIds, child) {
            if (favoriteBuildingIds.isEmpty) {
              return PlaceholderTile(
                minHeight: 56,
                content: [
                  LmuText.bodySmall(locals.canteen.emptyFavoritesBefore, color: placeholderTextColor),
                  StarIcon(isActive: false, disabledColor: starColor, size: LmuSizes.size_16),
                  LmuText.bodySmall(locals.canteen.emptyFavoritesAfter, color: placeholderTextColor),
                ],
              );
            }

            return ValueListenableBuilder(
              valueListenable: _buildingsNotifier,
              builder: (context, buildings, child) {
                final favoriteBuildings =
                    buildings.where((building) => favoriteBuildingIds.contains(building.id)).toList();
                return LmuContentTile(
                  contentList: favoriteBuildings.map(
                    (building) {
                      return LmuListItem.action(
                        key: Key('favorite${building.id}'),
                        title: building.title,
                        trailingTitle: building.distance?.formatDistance(),
                        actionType: LmuListItemAction.chevron,
                        onTap: () => RoomfinderBuildingDetailsRoute(building.id).go(context),
                      );
                    },
                  ).toList(),
                );
              },
            );
          },
        ),
        const SizedBox(height: LmuSizes.size_32),
      ],
    );
  }
}
