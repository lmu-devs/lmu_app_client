import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/libraries.dart';

import '../cubit/cubit.dart';
import '../pages/pages.dart';

class DefaultLibrariesService implements LibrariesService {
  @override
  Stream<List<ExploreLocation>> get librariesExploreLocationsStream {
    final librariesCubit = GetIt.I.get<LibrariesCubit>();

    final state = librariesCubit.state;
    if (state is! LibrariesLoadSuccess && state is! LibrariesLoadInProgress) {
      librariesCubit.loadLibraries();
    }

    return librariesCubit.stream.withInitialValue(librariesCubit.state).map((state) {
      if (state is LibrariesLoadInProgress && state.libraries != null) {
        return state.libraries!.map((libraryModel) {
          return ExploreLocation(
            id: libraryModel.id,
            latitude: libraryModel.location.latitude,
            longitude: libraryModel.location.longitude,
            address: libraryModel.location.address,
            name: libraryModel.name,
            type: ExploreMarkerType.library,
          );
        }).toList();
      } else if (state is LibrariesLoadSuccess) {
        return state.libraries.map((libraryModel) {
          return ExploreLocation(
            id: libraryModel.id,
            latitude: libraryModel.location.latitude,
            longitude: libraryModel.location.longitude,
            address: libraryModel.location.address,
            name: libraryModel.name,
            type: ExploreMarkerType.library,
          );
        }).toList();
      }
      return [];
    });
  }

  @override
  List<Widget> librariesMapContentBuilder(BuildContext context, String libraryId, ScrollController controller) {
    final librariesCubit = GetIt.I.get<LibrariesCubit>();
    final state = librariesCubit.state;
    if (state is! LibrariesLoadSuccess) {
      return [];
    } else {
      final libraryModel = state.libraries.firstWhereOrNull((libraryModel) => libraryModel.id == libraryId);
      if (libraryModel == null) {
        return [];
      }
      final images = libraryModel.images;
      return [
        if (images.isNotEmpty) SliverToBoxAdapter(child: LmuDynamicImageGallery(images: images)),
        SliverToBoxAdapter(
          child: LibraryDetailsPage(
            library: libraryModel,
            withAppBar: false,
            withMapButton: false,
          ),
        ),
      ];
    }
  }
}
