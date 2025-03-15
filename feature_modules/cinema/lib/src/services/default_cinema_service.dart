import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';

import '../../cinema.dart';
import '../cubit/cubit.dart';
import '../pages/cinema_page.dart';
import '../routes/cinema_routes.dart';

class DefaultCinemaService implements CinemaService {
  @override
  Widget get cinemaPage => const CinemaPage();

  @override
  RouteBase get cinemaData => $cinemaMainRoute;

  @override
  Stream<List<ExploreLocation>> get cinemaExploreLocationsStream {
    final cinemaCubit = GetIt.I.get<CinemaCubit>();

    final state = cinemaCubit.state;
    if (state is! CinemaLoadSuccess && state is! CinemaLoadInProgress) {
      cinemaCubit.loadCinemaData();
    }

    return cinemaCubit.stream.withInitialValue(cinemaCubit.state).map((state) {
      if (state is CinemaLoadSuccess) {
        return state.cinemas.map((cinemaModel) {
          return ExploreLocation(
            id: cinemaModel.id,
            latitude: cinemaModel.cinemaLocation.latitude,
            longitude: cinemaModel.cinemaLocation.longitude,
            name: cinemaModel.title,
            type: ExploreMarkerType.cinema,
          );
        }).toList();
      }
      return [];
    });
  }

  @override
  void navigateToCinemaPage(BuildContext context) {
    const CinemaMainRoute().go(context);
  }
}
