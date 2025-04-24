import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/libraries.dart';
import 'package:shared_api/explore.dart';

import '../../libraries.dart';
import '../cubit/cubit.dart';
import '../pages/pages.dart';
import '../routes/libraries_routes.dart';

class DefaultLibrariesService implements LibrariesService {
  @override
  Widget get librariesPage => const LibrariesPage();

  @override
  RouteBase get librariesData => $librariesMainRoute;

  @override
  Stream<List<ExploreLocation>> get librariesExploreLocationsStream {
    final librariesCubit = GetIt.I.get<LibrariesCubit>();

    final state = librariesCubit.state;
    if (state is! LibrariesLoadSuccess && state is! LibrariesLoadInProgress) {
      //libraryCubit.loadLibraryData();
    }

    return librariesCubit.stream.withInitialValue(librariesCubit.state).map((state) {
      /**if (state is LibrariesLoadInProgress && state.libraries != null) {
          return state.libraries!.map((libraryModel) {
          return ExploreLocation(
          id: libraryModel.id,
          latitude: libraryModel.libraryLocation.latitude,
          longitude: libraryModel.libraryLocation.longitude,
          address: libraryModel.libraryLocation.address,
          name: libraryModel.title,
          type: ExploreMarkerType.library,
          );
          }).toList();
          } else if (state is LibrariesLoadSuccess) {
          return state.libraries.map((libraryModel) {
          return ExploreLocation(
          id: libraryModel.id,
          latitude: libraryModel.libraryLocation.latitude,
          longitude: libraryModel.libraryLocation.longitude,
          name: libraryModel.title,
          address: libraryModel.libraryLocation.address,
          type: ExploreMarkerType.library,
          );
          }).toList();
          }**/
      return [];
    });
  }

  @override
  void navigateToLibrariesPage(BuildContext context) {
    const LibrariesMainRoute().go(context);
  }

  @override
  List<Widget> librariesMapContentBuilder(BuildContext context, String libraryId, ScrollController controller) {
    /**final librariesCubit = GetIt.I.get<LibrariesCubit>();
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
        if (images != null) SliverToBoxAdapter(child: LmuDynamicImageGallery(images: images)),
        SliverToBoxAdapter(
        child: LibraryDetailsPage(
        libraryDetailsData: LibraryDetailsData(
        library: libraryModel,
        screenings: getScreeningsForLibrary(state.screenings, libraryModel.id),
        ),
        withAppBar: false,
        ),
        ),
        ];
        }
        }**/
    return [];
  }
}
