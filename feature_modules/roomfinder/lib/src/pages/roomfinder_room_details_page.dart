import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../repository/api/models/roomfinder_room.dart';

class RoomfinderRoomDetailsPage extends StatelessWidget {
  const RoomfinderRoomDetailsPage({super.key, required this.room, required this.buildingId});

  final RoomfinderRoom room;
  final String buildingId;

  String get _url => "https://www.lmu.de/raumfinder/index.html#/building/$buildingId/map?room=${room.id}";

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LmuScaffold(
      appBar: LmuAppBarData(
        leadingAction: LeadingAction.back,
        largeTitle: room.name,
        largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
        largeTitleTrailingWidget: LmuInTextVisual.text(
          title: "Room",
          textColor: colors.warningColors.textColors.strongColors.base,
          backgroundColor: colors.customColors.backgroundColors.amber,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              LmuButton(
                title: "Open Roomfinder",
                showFullWidth: true,
                onTap: () {
                  LmuUrlLauncher.launchWebsite(context: context, url: _url);
                },
              ),
              LmuListItem.base(
                hasHorizontalPadding: false,
                title: room.name,
                subtitle: room.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
