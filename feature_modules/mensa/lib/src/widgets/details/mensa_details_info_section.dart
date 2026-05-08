import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../extensions/opening_hours_extensions.dart';
import '../../repository/api/api.dart';
import '../../services/mensa_status_update_service.dart';

class MensaDetailsInfoSection extends StatelessWidget {
  const MensaDetailsInfoSection({
    super.key,
    required this.mensaModel,
  });

  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.locals.app;
    final openingDetails = mensaModel.openingHours.openingHours;
    final servingDetails = mensaModel.openingHours.servingHours;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuListItem.base(
            subtitle: mensaModel.location.address,
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
                content: NavigationSheet(id: mensaModel.canteenId, location: mensaModel.location),
              );
            },
          ),
          ListenableBuilder(
            listenable: GetIt.I<MensaStatusUpdateService>(),
            builder: (context, child) {
              final openingStatusStyling = mensaModel.currentOpeningStatus.openingStatus(
                context,
                openingDetails: openingDetails,
              );
              final servingStatusStyling = mensaModel.currentServingStatus.servingStatus(
                context,
                openingDetails: servingDetails ?? [],
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusDropdown(
                    title: openingStatusStyling.text,
                    titleColor: openingStatusStyling.color,
                    details: openingDetails,
                    appLocalizations: appLocalizations,
                  ),
                  if (servingDetails?.isNotEmpty ?? false)
                    _buildStatusDropdown(
                      title: servingStatusStyling.text,
                      titleColor: servingStatusStyling.color,
                      details: servingDetails!,
                      appLocalizations: appLocalizations,
                    ),
                  const SizedBox(height: LmuSizes.size_16),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown({
    required String title,
    required Color titleColor,
    required List<MensaOpeningDetails> details,
    required AppLocalizations appLocalizations,
  }) {
    if (details.isEmpty) {
      return LmuListItem.base(
        hasHorizontalPadding: false,
        subtitle: title,
        subtitleTextColor: titleColor,
        mainContentAlignment: MainContentAlignment.center,
        hasDivider: true,
      );
    }
    return LmuListDropdown(
      subtitle: title,
      subtitleColor: titleColor,
      hasDivider: true,
      items: details.asMap().entries.map((entry) => _buildStatusItem(entry, appLocalizations)).toList(),
    );
  }

  LmuListItem _buildStatusItem(
    MapEntry<int, MensaOpeningDetails> entry,
    AppLocalizations appLocalizations,
  ) {
    final index = entry.key;
    final detail = entry.value;
    final isToday = DateTime.now().weekday - 1 == index;

    return LmuListItem.base(
      title: isToday ? detail.day.name : null,
      subtitle: !isToday ? detail.day.name : null,
      hasVerticalPadding: false,
      hasHorizontalPadding: false,
      trailingTitle: isToday ? '${detail.startTime.substring(0, 5)} - ${detail.endTime.substring(0, 5)}' : null,
      trailingSubtitle: !isToday ? '${detail.startTime.substring(0, 5)} - ${detail.endTime.substring(0, 5)}' : null,
    );
  }
}
