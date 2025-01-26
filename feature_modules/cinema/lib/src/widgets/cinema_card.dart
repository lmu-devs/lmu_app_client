import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../pages/cinema_details_page.dart';
import '../repository/api/api.dart';
import '../repository/api/models/screening_model.dart';
import '../routes/cinema_details_data.dart';

class CinemaCard extends StatelessWidget {
  const CinemaCard({
    Key? key,
    required this.cinema,
    required this.screenings,
    required this.isLastItem,
  }) : super(key: key);

  final CinemaModel cinema;
  final List<ScreeningModel> screenings;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: isLastItem ? LmuSizes.none : LmuSizes.size_12,
      ),
      padding: const EdgeInsets.all(LmuSizes.size_4),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: const BorderRadius.all(
          Radius.circular(LmuRadiusSizes.mediumLarge),
        ),
      ),
      child: LmuListItem.base(
        title: cinema.title,
        titleInTextVisuals: [LmuInTextVisual.text(title: cinema.id)],
        subtitle: 'Nächster Film • Morgen',
        hasHorizontalPadding: true,
        hasVerticalPadding: true,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CinemaDetailsPage(
              cinemaDetailsData: CinemaDetailsData(
                cinema: cinema,
                screenings: screenings,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
