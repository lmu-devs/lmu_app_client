import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
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
    final colors = context.colors;

    final openingHours = mensaModel.openingHours;
    final mensaStatus = openingHours.mensaStatus;
    return Padding(
      padding: const EdgeInsets.only(
        left: LmuSizes.size_16,
        right: LmuSizes.size_16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuListItem.base(
            subtitle: mensaModel.location.address,
            hasHorizontalPadding: false,
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
          ),
          const LmuDivider(),
          LmuListDropdown(
            title: mensaStatus.text(context.locals.canteen, openingHours: openingHours),
            titleColor: openingHours.mensaStatus.color(colors),
            items: openingHours.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final e = entry.value;
                final weekday = DateTime.now().weekday;

                return weekday - 1 == index
                    ? LmuListItem.base(
                        title: e.mapToDay(appLocalizations),
                        hasVerticalPadding: false,
                        hasHorizontalPadding: false,
                        trailingTitle:
                            '${e.startTime.substring(0, e.startTime.length - 3)} - ${e.endTime.substring(0, e.endTime.length - 3)}',
                      )
                    : LmuListItem.base(
                        subtitle: e.mapToDay(appLocalizations),
                        hasVerticalPadding: false,
                        hasHorizontalPadding: false,
                        trailingSubtitle:
                            '${e.startTime.substring(0, e.startTime.length - 3)} - ${e.endTime.substring(0, e.endTime.length - 3)}',
                      );
              },
            ).toList(),
          ),
          const SizedBox(height: LmuSizes.size_16),
        ],
      ),
    );
  }
}
