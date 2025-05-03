import 'package:flutter/material.dart';

import '../models/router_cinema_details_data.dart';
import '../models/router_screening_details_data.dart';
import '../models/router_screenings_history_data.dart';

abstract class CinemaRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, RCinemaDetailsData cinemaDetailsData);

  Widget buildScreeningDetails(BuildContext context, RScreeningDetailsData screeningDetailsData);

  Widget buildScreeningHistory(BuildContext context, RScreeningsHistoryData screeningsHistoryData);
}
