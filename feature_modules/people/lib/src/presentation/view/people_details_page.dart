import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/people_details_page_driver.dart';

class PeopleDetailsPage extends DrivableWidget<PeopleDetailsPageDriver> {
  PeopleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final starColor = context.colors.neutralColors.textColors.weakColors.base;
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.academicDegree.isNotEmpty ? "${driver.academicDegree} ${driver.name}" : driver.name,
        leadingAction: LeadingAction.back,
        largeTitleTrailingWidget: GestureDetector(
          onTap: () => driver.toggleFavorite(),
          child: StarIcon(
            isActive: driver.isFavorite,
            size: LmuIconSizes.small,
            disabledColor: starColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LmuTileHeadline.base(title: "Fakultät & Rolle"),
              LmuContentTile(
                contentList: [
                  LmuListItem.base(title: driver.faculty),
                  LmuListItem.base(
                    title: "${driver.role} ${driver.room}".trim(),
                  ) // Kombiniert beide Werte),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuTileHeadline.base(title: "Kontakt"),
              LmuContentTile(
                contentList: [
                  //if (driver.email.isNotEmpty)
                  LmuListItem.action(
                    title: "Email: mail ", //${driver.email}",
                    onTap: () => driver.onRoomTap(context),
                    actionType: LmuListItemAction.chevron,
                  ),
                  //if (driver.phone.isNotEmpty)
                  LmuListItem.action(
                    title: "Telefon: phone ", //${driver.email}",
                    onTap: () => driver.onRoomTap(context),
                    actionType: LmuListItemAction.chevron,
                  ),
                  if (driver.room.isNotEmpty)
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
      ),
    );
  }

  @override
  WidgetDriverProvider<PeopleDetailsPageDriver> get driverProvider => $PeopleDetailsPageDriverProvider();
}
