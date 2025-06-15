import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/people_details_page_driver.dart';

class PeopleDetailsPage extends DrivableWidget<PeopleDetailsPageDriver> {
  PeopleDetailsPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.name,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: "Fakultät & Lehrstuhl"),
            LmuContentTile(
              contentList: [
                LmuListItem.base(title: "Fakultät", subtitle: driver.faculty),
                LmuListItem.base(title: "Lehrstuhl", subtitle: driver.chair),
              ],
            ),
            const SizedBox(height: LmuSizes.size_16),
            LmuTileHeadline.base(title: "Kontakt"),
            LmuContentTile(
              contentList: [
                LmuListItem.base(title: "Email", subtitle: driver.email),
                LmuListItem.base(title: "Telefon", subtitle: driver.phone),
                LmuListItem.action(
                  title: "Raum: ${driver.room}",
                  onTap: () => driver.onRoomTap(context),
                  actionType: LmuListItemAction.chevron,
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_16),
            LmuTileHeadline.base(title: "Web"),
            LmuContentTile(
              contentList: [
                LmuListItem.action(
                  title: "Zur Website",
                  onTap: driver.onWebsiteTap,
                  actionType: LmuListItemAction.chevron,
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_16),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<PeopleDetailsPageDriver> get driverProvider =>
      $PeopleDetailsPageDriverProvider();
}
