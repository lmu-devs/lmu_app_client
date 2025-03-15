import 'package:core/components.dart';
import 'package:flutter/material.dart';

class RoomfinderSearchOverlay extends StatefulWidget {
  const RoomfinderSearchOverlay({super.key});

  @override
  State<RoomfinderSearchOverlay> createState() => _RoomfinderSearchOverlayState();
}

class _RoomfinderSearchOverlayState extends State<RoomfinderSearchOverlay> {
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
    return LmuSearchOverlay(
      searchController: _searchController,
      searchInputs: _searchInputs,
    );
  }
}
