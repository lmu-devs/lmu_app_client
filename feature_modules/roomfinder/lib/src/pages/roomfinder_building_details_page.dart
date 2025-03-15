import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../repository/api/models/roomfinder_building.dart';
import '../repository/api/models/roomfinder_floor.dart';

class RoomfinderBuildingDetailsPage extends StatefulWidget {
  const RoomfinderBuildingDetailsPage({super.key, required this.building});

  final RoomfinderBuilding building;

  @override
  State<RoomfinderBuildingDetailsPage> createState() => _RoomfinderBuildingDetailsPageState();
}

class _RoomfinderBuildingDetailsPageState extends State<RoomfinderBuildingDetailsPage> {
  final buildingColor = const Color(0xFF39A6F9);

  late PageController _pageController;

  late ValueNotifier<int> _activeTabIndexNotifier;

  List<RoomfinderFloor> get _floors => widget.building.buildingParts.first.floors;

  @override
  void initState() {
    super.initState();
    _activeTabIndexNotifier = ValueNotifier<int>(0);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      leadingAction: LeadingAction.back,
      largeTitle: widget.building.title,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      largeTitleTrailingWidget: LmuInTextVisual.text(
        title: "Building",
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
                  LmuListItem.base(
                    subtitle: widget.building.location.address,
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
                          latitude: widget.building.location.latitude,
                          longitude: widget.building.location.longitude,
                          address: widget.building.location.address,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: LmuSizes.size_16),
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
                                  "https://www.lmu.de/raumfinder/index.html#/building/${widget.building.id}/map?room=${room.id}";
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
}
