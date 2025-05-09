import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../extensions/equipment_icon_extension.dart';
import '../repository/api/api.dart';
import '../routes/libraries_routes.dart';
import '../services/libraries_user_preference_service.dart';
import '../widgets/libraries_list_section.dart';

class LibraryDetailsPage extends StatelessWidget {
  const LibraryDetailsPage({
    super.key,
    required this.library,
    this.withAppBar = true,
  });

  final LibraryModel library;
  final bool withAppBar;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_8),
        LmuButtonRow(
          buttons: [
            if (library.reservationUrl != null && library.reservationUrl!.isNotEmpty)
              LmuButton(
                title: context.locals.libraries.seatBooking,
                leadingIcon: LucideIcons.armchair,
                emphasis: ButtonEmphasis.secondary,
                onTap: () => LmuUrlLauncher.launchWebsite(url: library.reservationUrl!, context: context),
              ),
            if (library.url.isNotEmpty)
              LmuButton(
                title: "Website",
                emphasis: ButtonEmphasis.secondary,
                onTap: () => LmuUrlLauncher.launchWebsite(url: library.url, context: context),
              ),
            if (library.phones != null && library.phones!.isNotEmpty)
              LmuButton(
                title: context.locals.app.phone,
                emphasis: ButtonEmphasis.secondary,
                onTap: () => library.phones!.length > 1
                    ? LmuBottomSheet.show(
                        context,
                        content: PhoneSheet(phones: library.phones!),
                      )
                    : LmuUrlLauncher.launchPhone(
                        phoneNumber: library.phones!.first.number,
                        context: context,
                      ),
              ),
          ],
        ),
        const SizedBox(height: LmuSizes.size_16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              LmuListItem.base(
                subtitle: library.location.address,
                trailingArea: Icon(
                  LucideIcons.map,
                  size: LmuIconSizes.mediumSmall,
                  color: context.colors.neutralColors.textColors.weakColors.base,
                ),
                hasHorizontalPadding: false,
                hasDivider: true,
                onTap: () {
                  LmuBottomSheet.show(
                    context,
                    content: NavigationSheet(location: library.location),
                  );
                },
              ),
              if (library.areas.isNotEmpty)
                library.areas.length == 1
                    ? Container()
                    : LmuListItem.action(
                        subtitle: "${library.areas.length} ${context.locals.libraries.areas}",
                        actionType: LmuListItemAction.chevron,
                        hasHorizontalPadding: false,
                        hasDivider: true,
                        onTap: () => LibraryAreasRoute(library).go(context),
                      ),
            ],
          ),
        ),
        LibrariesListSection(
          title: context.locals.libraries.equipment,
          count: library.equipment.length,
          items: library.equipment
              .map(
                (equipment) => LmuListItem.base(
                  title: equipment.title,
                  subtitle: equipment.description,
                  leadingArea: Icon(equipment.getIcon()),
                  onTap: () => equipment.url != null && equipment.url!.isNotEmpty
                      ? LmuUrlLauncher.launchWebsite(url: equipment.url!, context: context)
                      : null,
                ),
              )
              .toList(),
        ),
        LibrariesListSection(
          title: context.locals.libraries.subjectAreas,
          count: library.subjects.length,
          items: library.subjects
              .map(
                (subject) => LmuListItem.base(title: subject),
              )
              .toList(),
        ),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );

    if (!withAppBar) return content;

    return LmuMasterAppBar(
      largeTitle: library.name,
      leadingAction: LeadingAction.back,
      trailingWidgets: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
          child: ValueListenableBuilder(
            valueListenable: GetIt.I<LibrariesUserPreferenceService>().favoriteLibraryIdsNotifier,
            builder: (context, favoriteLibraryIds, _) {
              final isFavorite = favoriteLibraryIds.contains(library.id);
              final calculatedLikes = library.rating.calculateLikeCount(isFavorite);
              return LmuFavoriteButton(
                isFavorite: isFavorite,
                calculatedLikes: calculatedLikes,
                onTap: () => GetIt.I<LibrariesUserPreferenceService>().toggleFavoriteLibraryId(library.id),
              );
            },
          ),
        ),
      ],
      imageUrls: library.images.isNotEmpty ? library.images.map((image) => image.url).toList() : [],
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      largeTitleTrailingWidget: LmuInTextVisual.text(
        title: context.locals.libraries.library,
        size: InTextVisualSize.large,
        textColor: context.colors.customColors.textColors.library,
        backgroundColor: context.colors.customColors.backgroundColors.library,
      ),
      body: SingleChildScrollView(
        child: content,
      ),
    );
  }
}
