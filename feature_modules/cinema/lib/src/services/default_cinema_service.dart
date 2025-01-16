import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/cinema.dart';
import '../pages/cinema_main.dart';

import '../../cinema.dart';
import '../routes/cinema_routes.dart';

class DefaultCinemaService implements CinemaService {
  @override
  Widget get cinemaMainPage => const CinemaMainPage();

  @override
  RouteBase get cinemaData => $cinemaMainRoute;
}
