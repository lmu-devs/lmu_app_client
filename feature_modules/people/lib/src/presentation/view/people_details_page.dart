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
          largeTitle: driver.loadingText,
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
          largeTitle: driver.personNotFoundText,
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: LmuText.body(driver.personNotFoundText),
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
            LmuTileHeadline.base(title: driver.facultyAndRoleText),
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
            LmuTileHeadline.base(title: driver.contactText),
            const SizedBox(height: LmuSizes.size_2),
            LmuContentTile(
              contentList: [
                LmuListItem.base(
                  title: driver.emailText,
                  subtitle: driver.email,
                  trailingArea: const Icon(Icons.mail_outline),
                  onTap: () => driver.onEmailTap(),
                ),
                LmuListItem.base(
                  title: driver.phoneText,
                  subtitle: driver.phone,
                  trailingArea: const Icon(Icons.phone_outlined),
                  onTap: () => driver.onPhoneTap(),
                ),
                LmuListItem.base(
                  title: driver.websiteText,
                  subtitle: driver.website,
                  trailingArea: const Icon(Icons.open_in_new),
                  onTap: () => driver.onWebsiteTap(),
                ),
                LmuListItem.base(
                  title: driver.roomText,
                  subtitle: driver.room,
                  trailingArea: const Icon(Icons.map_outlined),
                  onTap: () => driver.onRoomTap(),
                ),
                LmuListItem.base(
                  title: driver.consultationHoursText,
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
