import 'package:core_routes/cinema.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';
import 'cinema_details_data.dart';
import 'screening_details_data.dart';
import 'screenings_history_data.dart';

class CinemaRouterImpl extends CinemaRouter {
  @override
  Widget buildMain(BuildContext context) => const CinemaPage();

  @override
  Widget buildDetails(BuildContext context, RCinemaDetailsData cinemaDetailsData) =>
      CinemaDetailsPage(cinemaDetailsData: cinemaDetailsData as CinemaDetailsData);

  @override
  Widget buildScreeningDetails(BuildContext context, RScreeningDetailsData screeningDetailsData) =>
      ScreeningDetailsPage(screeningDetailsData: screeningDetailsData as ScreeningDetailsData);

  @override
  Widget buildScreeningHistory(BuildContext context, RScreeningsHistoryData screeningsHistoryData) =>
      ScreeningsHistoryPage(screeningsHistoryData: screeningsHistoryData as ScreeningsHistoryData);
}
