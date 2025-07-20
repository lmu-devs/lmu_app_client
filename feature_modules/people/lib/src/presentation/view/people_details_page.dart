import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
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
        trailingWidgets: [
          LmuFavoriteButton(
            isFavorite: driver.isFavorite,
            onTap: driver.onFavoriteTap,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            LmuSizes.size_16,
            LmuSizes.size_2, 
            LmuSizes.size_16,
            LmuSizes.size_16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (driver.facultyAndRole.isNotEmpty) ...[
                LmuTileHeadline.base(title: driver.facultyAndRole),
                const SizedBox(height: LmuSizes.size_2),
              ],
              
              const SizedBox(height: LmuSizes.size_32), 
              LmuTileHeadline.base(title: driver.contactText),
              const SizedBox(height: LmuSizes.size_2),
              LmuContentTile(
                contentList: [
                  if (driver.email.isNotEmpty)
                    LmuListItem.base(
                      title: driver.email,
                      subtitle: driver.emailText,
                      leadingArea: LmuIconButton(
                        icon: LucideIcons.mail,
                        onPressed: () => driver.onEmailTap(context),
                      ),
                      trailingArea: LmuIconButton(
                        icon: LucideIcons.copy,
                        onPressed: () => CopyToClipboardUtil.copyToClipboard(
                          context: context,
                          copiedText: driver.email,
                          message: driver.copiedToClipboardText,
                        ),
                      ),
                    ),
                  if (driver.phone.isNotEmpty)
                    LmuListItem.base(
                      title: driver.phone,
                      subtitle: driver.phoneText,
                      leadingArea: LmuIconButton(
                        icon: LucideIcons.phone,
                        onPressed: () => driver.onPhoneTap(context),
                      ),
                      trailingArea: LmuIconButton(
                        icon: LucideIcons.copy,
                        onPressed: () => CopyToClipboardUtil.copyToClipboard(
                          context: context,
                          copiedText: driver.phone,
                          message: driver.copiedPhoneText,
                        ),
                      ),
                    ),
                  if (driver.website.isNotEmpty)
                    LmuListItem.base(
                      title: driver.website,
                      subtitle: driver.websiteText,
                      leadingArea: LmuIconButton(
                        icon: LucideIcons.globe,
                        onPressed: () => driver.onWebsiteTap(context),
                      ),
                      trailingArea: LmuIconButton(
                        icon: LucideIcons.copy,
                        onPressed: () => CopyToClipboardUtil.copyToClipboard(
                          context: context,
                          copiedText: driver.website,
                          message: driver.copiedToClipboardText,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                contentList: [
                  if (driver.room.isNotEmpty)
                    LmuListItem.base(
                      title: driver.roomText,
                      subtitle: driver.room,
                      trailingArea: LmuIconButton(
                        icon: LucideIcons.map_pin,
                        onPressed: () => driver.onRoomTap(),
                      ),
                    ),
                  if (driver.consultation.isNotEmpty)
                    LmuListItem.base(
                      title: driver.consultationHoursText,
                      subtitle: driver.consultation,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<PeopleDetailsPageDriver> get driverProvider =>
      $PeopleDetailsPageDriverProvider(personId: personId);
}
