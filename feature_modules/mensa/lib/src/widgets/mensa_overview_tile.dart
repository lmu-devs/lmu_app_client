import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import 'mensa_tag.dart';

class MensaOverviewTile extends StatelessWidget {
  const MensaOverviewTile({
    super.key,
    required this.title,
    this.distance,
  });

  final String title;
  final double? distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: spacingAtoms.tileItemPaddingVertical,
        horizontal: spacingAtoms.tileItemPaddingHorizontal,
      ),
      child: GestureDetector(
        onTap: () {
          print("Tapped");
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: spacingAtoms.tileItemPaddingVertical,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HeadingSection(
                isFavorite: false,
                title: title,
                type: "Mensa",
                status: "Open now",
                distance: "1.2 km",
              ),
              SizedBox(
                height: spacingAtoms.visualSizes.xsmall,
              ),
              const _ImageSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: spacingAtoms.tileItemPaddingHorizontal,
      ),
      child: Container(
        width: double.infinity,
        height: 64,
        color: Colors.red,
      ),
    );
  }
}

class _HeadingSection extends StatelessWidget {
  const _HeadingSection({
    required this.isFavorite,
    required this.title,
    required this.type,
    required this.status,
    required this.distance,
  });

  final bool isFavorite;
  final String title;
  final String type;
  final String status;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: spacingAtoms.tileItemPaddingHorizontal + spacingAtoms.tilePadding,
        right: spacingAtoms.tileItemPaddingHorizontal + spacingAtoms.tilePadding,
        top: spacingAtoms.tilePadding,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  JoyText.h3(title),
                  SizedBox(
                    width: 8,
                  ),
                  MensaTag(),
                ],
              ),
              isFavorite
                  ? Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  : Icon(
                      Icons.star_border,
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              JoyText.body(
                "Open now",
              ),
              JoyText.body(
                " • 1.2 km",
              ),
            ],
          )
        ],
      ),
    );
  }
}
