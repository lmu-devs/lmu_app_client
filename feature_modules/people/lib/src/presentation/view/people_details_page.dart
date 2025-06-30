import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/people_details_page_driver.dart';

class PeopleDetailsPage extends DrivableWidget<PeopleDetailsPageDriver> {
  PeopleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person = driver.person;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle:
            '${person.academicDegree != null && person.academicDegree!.isNotEmpty ? person.academicDegree! + ' ' : ''}${person.name} ${person.surname}',
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          LmuSizes.size_16,
          LmuSizes.size_32,
          LmuSizes.size_16,
          LmuSizes.size_16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuTileHeadline.base(title: "Fakultät & Rolle"),
            const SizedBox(height: LmuSizes.size_2),
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  title: driver.faculty,
                ),
                LmuListItem.base(
                  title: driver.role,
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_32),
            LmuTileHeadline.base(title: "Kontakt"),
            const SizedBox(height: LmuSizes.size_2),
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  title: "E-Mail",
                  subtitle: driver.email,
                  //trailing: const Icon(Icons.mail_outline),
                ),
                LmuListItem.base(
                  title: "Telefon",
                  subtitle: driver.phone,
                  //trailing: const Icon(Icons.phone_outlined),
                ),
                LmuListItem.base(
                  title: "Website",
                  subtitle: driver.website,
                  //trailing: const Icon(Icons.open_in_new),
                ),
                LmuListItem.base(
                  title: "Raum",
                  subtitle: driver.room,
                  //trailing: const Icon(Icons.map_outlined),
                ),
                LmuListItem.base(
                  title: "Sprechstunde",
                  subtitle: driver.consultation,
                  //trailing: const Icon(Icons.schedule_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<PeopleDetailsPageDriver> get driverProvider => $PeopleDetailsPageDriverProvider();
}
