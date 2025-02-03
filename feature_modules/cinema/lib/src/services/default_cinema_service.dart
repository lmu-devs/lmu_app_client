import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/cinema.dart';
import '../../cinema.dart';
import '../pages/cinema_page.dart';
import '../routes/cinema_routes.dart';
import '../widgets/widgets.dart';

class DefaultCinemaService implements CinemaService {
  @override
  Widget get cinemaPage => const CinemaPage();

  @override
  StatefulShellBranch get cinemaData => $cinemaMainRoute;

  @override
  Widget movieTeaserList({String? headlineActionText, VoidCallback? headlineActionFunction}) {
    return MovieTeaserList(
      headlineActionText: headlineActionText,
      headlineActionFunction: headlineActionFunction,
    );
  }
}
