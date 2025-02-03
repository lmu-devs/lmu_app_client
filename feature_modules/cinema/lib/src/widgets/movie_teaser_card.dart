import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../pages/screening_details_page.dart';
import '../repository/api/api.dart';
import '../routes/screening_details_data.dart';
import '../util/cinema_type.dart';
import '../util/screening_time.dart';

class MovieTeaserCard extends StatelessWidget {
  const MovieTeaserCard({
    super.key,
    required this.screening,
    required this.cinemaScreenings,
  });

  final ScreeningModel screening;
  final List<ScreeningModel> cinemaScreenings;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ScreeningDetailsPage(
            screeningDetailsData: ScreeningDetailsData(
              screening: screening,
              cinemaScreenings: cinemaScreenings,
            ),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 115,
            height: 165,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
            ),
            child: screening.movie.poster != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.medium)),
                    child: LmuCachedNetworkImage(
                      imageUrl: screening.movie.poster!.url,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                      borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.medium)),
                    ),
                    child: Center(
                      child: LmuText.caption(screening.movie.title),
                    ),
                  ),
          ),
          const SizedBox(height: LmuSizes.size_8),
          SizedBox(
            width: 115,
            child: Wrap(
              spacing: LmuSizes.size_4,
              runSpacing: LmuSizes.size_2,
              alignment: WrapAlignment.center,
              children: [
                LmuInTextVisual.text(
                  title: screening.cinema.type.getValue(),
                  textColor: screening.cinema.type.getTextColor(context),
                  backgroundColor: screening.cinema.type.getBackgroundColor(context),
                ),
                LmuInTextVisual.text(title: '${screening.price.toStringAsFixed(2)} €'),
              ],
            ),
          ),
          const SizedBox(height: LmuSizes.size_8),
          LmuText.bodySmall(
            getScreeningTime(context: context, time: screening.startTime).split('•').first,
          ),
        ],
      ),
    );
  }
}
