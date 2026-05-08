import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../repository/api/models/models.dart';

class RoomfinderBuildingFloorsSection extends StatefulWidget {
  const RoomfinderBuildingFloorsSection({
    super.key,
    required List<RoomfinderFloor> floors,
    required RoomfinderBuilding building,
  })  : _floors = floors,
        _building = building;

  final List<RoomfinderFloor> _floors;
  final RoomfinderBuilding _building;

  @override
  State<RoomfinderBuildingFloorsSection> createState() => _RoomfinderBuildingFloorsSectionState();
}

class _RoomfinderBuildingFloorsSectionState extends State<RoomfinderBuildingFloorsSection> {
  late PageController _pageController;
  late ValueNotifier<int> _activeTabIndexNotifier;

  @override
  void initState() {
    super.initState();
    _activeTabIndexNotifier = ValueNotifier<int>(0);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: LmuTabBar(
        activeTabIndexNotifier: _activeTabIndexNotifier,
        hasDivider: true,
        items: widget._floors
            .map(
              (floor) => LmuTabBarItemData(title: floor.name),
            )
            .toList(),
        onTabChanged: (index, _) => _pageController.jumpToPage(index),
      ),
      sliver: SliverToBoxAdapter(
        child: ExpandablePageView.builder(
          animationDuration: const Duration(milliseconds: 200),
          itemCount: widget._floors.length,
          controller: _pageController,
          animationCurve: Curves.bounceIn,
          onPageChanged: (index) => _activeTabIndexNotifier.value = index,
          itemBuilder: (_, index) {
            final floor = widget._floors[index];
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
                            "https://www.lmu.de/raumfinder/index.html#/building/${widget._building.id}/map?room=${room.id}";
                        LmuUrlLauncher.launchWebsite(
                          context: context,
                          url: url,
                          mode: LmuUrlLauncherMode.inAppWebView,
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
