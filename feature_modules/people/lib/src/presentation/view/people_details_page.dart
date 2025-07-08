import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/people_details_page_driver.dart';

class PeopleDetailsPage extends DrivableWidget<PeopleDetailsPageDriver> {
  PeopleDetailsPage({super.key, required this.personId});

  final int personId;

  @override
  Widget build(BuildContext context) {
    final person = driver.person;

    if (driver.isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: 'Loading...',
          leadingAction: LeadingAction.back,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (person == null) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: 'Person not found',
          leadingAction: LeadingAction.back,
        ),
        body: const Center(
          child: Text('Person not found'),
        ),
      );
    }

    final fullName =
        '${person.academicDegree != null && person.academicDegree!.isNotEmpty ? person.academicDegree! + ' ' : ''}${person.name} ${person.surname}';

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: fullName,
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
                  trailingArea: const Icon(Icons.mail_outline),
                  onTap: () => driver.onEmailTap(),
                ),
                LmuListItem.base(
                  title: "Telefon",
                  subtitle: driver.phone,
                  trailingArea: const Icon(Icons.phone_outlined),
                  onTap: () => driver.onPhoneTap(),
                ),
                LmuListItem.base(
                  title: "Website",
                  subtitle: driver.website,
                  trailingArea: const Icon(Icons.open_in_new),
                  onTap: () => driver.onWebsiteTap(),
                ),
                LmuListItem.base(
                  title: "Raum",
                  subtitle: driver.room,
                  trailingArea: const Icon(Icons.map_outlined),
                  onTap: () => driver.onRoomTap(),
                ),
                LmuListItem.base(
                  title: "Sprechstunde",
                  subtitle: driver.consultation,
                  trailingArea: const Icon(Icons.schedule_outlined),
                  onTap: () => driver.onConsultationTap(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<PeopleDetailsPageDriver> get driverProvider =>
      $PeopleDetailsPageDriverProvider(personId: personId);
}
