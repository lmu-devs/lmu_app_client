import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../cubit/cubit.dart';
import '../repository/api/models/models.dart';
import '../routes/roomfinder_routes.dart';
import '../services/roomfinder_room_search_service.dart';
import '../services/services.dart';

class RoomfinderBuildingDetailsPage extends StatefulWidget {
  const RoomfinderBuildingDetailsPage({super.key, required this.buildingId});

  final String buildingId;

  @override
  State<RoomfinderBuildingDetailsPage> createState() => _RoomfinderBuildingDetailsPageState();
}

class _RoomfinderBuildingDetailsPageState extends State<RoomfinderBuildingDetailsPage> {
  final buildingColor = const Color(0xFF39A6F9);

  late PageController _pageController;

  late ValueNotifier<int> _activeTabIndexNotifier;

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

    _activeTabIndexNotifier = ValueNotifier<int>(0);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      leadingAction: LeadingAction.back,
      largeTitle: _building.title,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      trailingWidgets: [_trailingAppBarAction],
      largeTitleTrailingWidget: LmuInTextVisual.text(
        title: context.locals.roomfinder.building,
        textColor: buildingColor,
        backgroundColor: buildingColor.withOpacity(0.14),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
                          content: NavigationSheet(
                            latitude: _building.location.latitude,
                            longitude: _building.location.longitude,
                            address: _building.location.address,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: LmuSizes.size_16),
              child: Row(
                children: [
                  const SizedBox(width: LmuSizes.size_16),
                  LmuMapImageButton(onTap: () => GetIt.I<ExploreService>().navigateToExplore(context)),
                  const SizedBox(width: LmuSizes.size_8),
                  LmuIconButton(
                    icon: LucideIcons.search,
                    onPressed: () {
                      if (GetIt.I.isRegistered<RoomfinderRoomSearchService>()) {
                        GetIt.I.unregister<RoomfinderRoomSearchService>();
                      }

                      final instance = RoomfinderRoomSearchService(
                        buildingPartId: _building.buildingPartId,
                        buildingId: _building.id,
                      );
                      GetIt.I.registerSingleton<RoomfinderRoomSearchService>(instance);
                      instance.init().then((_) => RoomfinderRoomSearchRoute(_building.buildingPartId).go(context));
                    },
                  ),
                  const SizedBox(width: LmuSizes.size_16),
                ],
              ),
            ),
          ),
          SliverStickyHeader(
            header: LmuTabBar(
              activeTabIndexNotifier: _activeTabIndexNotifier,
              hasDivider: true,
              items: _floors
                  .map(
                    (floor) => LmuTabBarItemData(title: floor.name),
                  )
                  .toList(),
              onTabChanged: (index, _) => _pageController.jumpToPage(index),
            ),
            sliver: SliverToBoxAdapter(
              child: ExpandablePageView.builder(
                animationDuration: const Duration(milliseconds: 200),
                itemCount: _floors.length,
                controller: _pageController,
                animationCurve: Curves.bounceIn,
                onPageChanged: (index) => _activeTabIndexNotifier.value = index,
                itemBuilder: (_, index) {
                  final floor = _floors[index];
                  final rooms = floor.rooms;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(
                      LmuSizes.size_16,
                      LmuSizes.size_16,
                      LmuSizes.size_16,
                      LmuSizes.size_96,
                    ),
                    child: LmuContentTile(
                      content: ListView.builder(
                        itemCount: rooms.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final room = rooms[index];
                          return LmuListItem.base(
                            key: Key(room.id),
                            title: room.name,
                            trailingArea: LmuIcon(
                              icon: LucideIcons.external_link,
                              size: LmuIconSizes.mediumSmall,
                              color: context.colors.neutralColors.textColors.weakColors.base,
                            ),
                            onTap: () {
                              final url =
                                  "https://www.lmu.de/raumfinder/index.html#/building/${_building.id}/map?room=${room.id}";
                              LmuUrlLauncher.launchWebsite(context: context, url: url);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
