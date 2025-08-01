import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';

import '../cubit/cubit.dart';
import '../pages/cinema_details_page.dart';
import '../routes/cinema_details_data.dart';
import '../util/cinema_screenings.dart';

class DefaultCinemaService implements CinemaService {
  @override
  Stream<List<ExploreLocation>> get cinemaExploreLocationsStream {
    final cinemaCubit = GetIt.I.get<CinemaCubit>();

    final state = cinemaCubit.state;
    if (state is! CinemaLoadSuccess && state is! CinemaLoadInProgress) {
      cinemaCubit.loadCinemaData();
    }

    return cinemaCubit.stream.withInitialValue(cinemaCubit.state).map((state) {
      if (state is CinemaLoadInProgress && state.cinemas != null) {
        return state.cinemas!.map((cinemaModel) {
          return ExploreLocation(
            id: cinemaModel.id,
            latitude: cinemaModel.location.latitude,
            longitude: cinemaModel.location.longitude,
            address: cinemaModel.location.address,
            name: cinemaModel.title,
            type: ExploreMarkerType.cinema,
          );
        }).toList();
      } else if (state is CinemaLoadSuccess) {
        return state.cinemas.map((cinemaModel) {
          return ExploreLocation(
            id: cinemaModel.id,
            latitude: cinemaModel.location.latitude,
            longitude: cinemaModel.location.longitude,
            name: cinemaModel.title,
            address: cinemaModel.location.address,
            type: ExploreMarkerType.cinema,
          );
        }).toList();
      }
      return [];
    });
  }

  @override
  List<Widget> cinemaMapContentBuilder(BuildContext context, String cinemaId, ScrollController controller) {
    final cinemaCubit = GetIt.I.get<CinemaCubit>();
    final state = cinemaCubit.state;
    if (state is! CinemaLoadSuccess) {
      return [];
    } else {
      final cinemaModel = state.cinemas.firstWhereOrNull((cinemaModel) => cinemaModel.id == cinemaId);
      if (cinemaModel == null) {
        return [];
      }
      final images = cinemaModel.images;
      return [
        if (images != null) SliverToBoxAdapter(child: LmuDynamicImageGallery(images: images)),
        SliverToBoxAdapter(
          child: CinemaDetailsPage(
            cinemaDetailsData: CinemaDetailsData(
              cinema: cinemaModel,
              screenings: getScreeningsForCinema(state.screenings, cinemaModel.id),
            ),
            withAppBar: false,
            withMapButton: false,
          ),
        ),
      ];
    }
  }
}
