import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';

import '../../extensions/opening_hours_extensions.dart';
import '../../repository/api/api.dart';

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

    final openingStatusStyling = mensaModel.currentOpeningStatus.openingStatus(
      context,
      openingDetails: openingDetails,
    );
    final servingStatusStyling = mensaModel.currentServingStatus.servingStatus(
      context,
      openingDetails: servingDetails ?? [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationTile(context),
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
      ),
    );
  }

  Widget _buildLocationTile(BuildContext context) {
    return LmuListItem.base(
      subtitle: mensaModel.location.address,
      hasHorizontalPadding: false,
      hasDivider: true,
      onTap: () {
        LmuBottomSheet.show(
          context,
          content: NavigationSheet(
            latitude: mensaModel.location.latitude,
            longitude: mensaModel.location.longitude,
            address: mensaModel.location.address,
          ),
        );
      },
    );
  }

  Widget _buildStatusDropdown({
    required String title,
    required Color titleColor,
    required List<MensaOpeningDetails> details,
    required AppLocalizations appLocalizations,
  }) {
    return LmuListDropdown(
      title: title,
      titleColor: titleColor,
      hasDivier: true,
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
      title: isToday ? detail.mapToDay(appLocalizations) : null,
      subtitle: !isToday ? detail.mapToDay(appLocalizations) : null,
      hasVerticalPadding: false,
      hasHorizontalPadding: false,
      trailingTitle: isToday ? '${detail.startTime.substring(0, 5)} - ${detail.endTime.substring(0, 5)}' : null,
      trailingSubtitle: !isToday ? '${detail.startTime.substring(0, 5)} - ${detail.endTime.substring(0, 5)}' : null,
    );
  }
}
