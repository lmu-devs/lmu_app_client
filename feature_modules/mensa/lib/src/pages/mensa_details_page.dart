import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/api.dart';

class MensaDetailsPage extends StatelessWidget {
  const MensaDetailsPage({
    super.key,
    required this.mensaModel,
  });

  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    final openingHours = mensaModel.openingHours;

    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                'https://www.byak.de/preiseundco-proxy/images/projekte/538/63a07e3ad2d28676dc35fbb7/b20352fdf91b24c98b9483d5f9083c6e.jpg?w=1260&h=648',
                height: 267,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              const SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: LmuSizes.mediumLarge,
                  ),
                  child: Row(
                    children: [
                      _DetailsBackButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: LmuSizes.mediumLarge,
              right: LmuSizes.mediumLarge,
              top: LmuSizes.mediumSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: LmuSizes.medium,
                  ),
                  child: LmuText.h1(
                    mensaModel.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: LmuSizes.medium,
                  ),
                  child: LmuText.body(
                    mensaModel.location.address,
                    color: context.colors.neutralColors.textColors.mediumColors.base,
                  ),
                ),
                LmuListDropdown(
                  title: "Heute geöffnet bis ",
                  titleColor: Colors.green,
                  items: openingHours
                      .map((e) => LmuListItem.base(
                            title: e.day,
                            hasVerticalPadding: false,
                            hasHorizontalPadding: false,
                            trailingTitle:
                                '${e.startTime.substring(0, e.startTime.length - 3)} - ${e.endTime.substring(0, e.endTime.length - 3)} Uhr',
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsBackButton extends StatelessWidget {
  const _DetailsBackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.neutralColors.backgroundColors.tile,
        ),
        child: LmuIcon(
          icon: Icons.arrow_back,
          size: LmuIconSizes.medium,
          color: context.colors.neutralColors.textColors.strongColors.base,
        ),
      ),
    );
  }
}
