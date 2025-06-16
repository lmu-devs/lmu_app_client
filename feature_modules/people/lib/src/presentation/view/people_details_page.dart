import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/people_details_page_driver.dart';

class PeopleDetailsPage extends DrivableWidget<PeopleDetailsPageDriver> {
  PeopleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.academicDegree.isNotEmpty ? "${driver.academicDegree} ${driver.name}" : driver.name,
        leadingAction: LeadingAction.back,
        largeTitleTrailingWidget: IconButton(
          icon: Icon(
            driver.isFavorite ? Icons.star : Icons.star_border, // Stern gefüllt oder leer
            color: driver.isFavorite ? Colors.yellow : Colors.grey, // Farbe abhängig vom Status
          ),
          onPressed: () => driver.toggleFavorite(), // Funktion zum Favorisieren
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
                  if (driver.email.isNotEmpty) LmuListItem.base(title: "Email", subtitle: driver.email),
                  if (driver.phone.isNotEmpty) LmuListItem.base(title: "Telefon", subtitle: driver.phone),
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
