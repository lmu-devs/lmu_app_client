import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../repository/api/api.dart';
import '../../widgets/widgets.dart';

class MensaDetailsInfoSection extends StatelessWidget {
  const MensaDetailsInfoSection({
    super.key,
    required this.mensaModel,
  });

  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    final canteenLocalizations = context.locals.canteen;
    final appLocalizations = context.locals.app;
    final colors = context.colors;

    final openingHours = mensaModel.openingHours;
    return Padding(
      padding: const EdgeInsets.only(
        left: LmuSizes.mediumLarge,
        right: LmuSizes.mediumLarge,
        top: LmuSizes.mediumSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.medium),
          Row(
            children: [
              LmuText.h1(mensaModel.name),
              const SizedBox(width: 8),
              MensaTag(type: mensaModel.type),
            ],
          ),
          const SizedBox(height: LmuSizes.medium),
          Row(
            children: [
              LmuButton(
                title: "${mensaModel.ratingModel.likeCount.formattedLikes} Likes",
                emphasis: ButtonEmphasis.secondary,
                onTap: () {},
              ),
              const SizedBox(width: LmuSizes.mediumSmall),
              LmuButton(
                title: "Google Maps",
                emphasis: ButtonEmphasis.secondary,
                onTap: () {
                  final lng = mensaModel.location.longitude;
                  final lat = mensaModel.location.latitude;
                  LmuUrlLauncher.launchWebsite(
                    context: context,
                    url: "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
                    mode: LmuUrlLauncherMode.externalApplication,
                  );
                },
              ),
              const SizedBox(width: LmuSizes.mediumSmall),
              LmuButton(
                title: canteenLocalizations.share,
                emphasis: ButtonEmphasis.secondary,
                onTap: () {},
              )
            ],
          ),
          const SizedBox(height: LmuSizes.mediumLarge),
          LmuListItem.base(
            subtitle: mensaModel.location.address,
            hasHorizontalPadding: false,
          ),
          Divider(thickness: .5, height: 0, color: colors.neutralColors.borderColors.seperatorLight),
          LmuListDropdown(
            title: "Heute geschlossen",
            titleColor: openingHours.mensaStatus.textColor(colors),
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
          const SizedBox(height: LmuSizes.mediumLarge),
        ],
      ),
    );
  }
}
