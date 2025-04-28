import 'package:core/logging.dart';
import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../cubit/cubit.dart';
import '../extensions/extensions.dart';
import '../repository/api/api.dart';
import '../repository/api/enums/sort_options.dart';
import '../repository/libraries_repository.dart';

class LibrariesUserPreferenceService {
  LibrariesUserPreferenceService() {
    _init();
  }

  ValueNotifier<bool> get isOpenNowFilterNotifier => _isOpenNowFilterNotifier;
  ValueNotifier<SortOption> get sortOptionNotifier => _sortOptionNotifier;
  ValueNotifier<List<LibraryModel>> get sortedLibrariesNotifier => _sortedLibrariesNotifier;
  ValueNotifier<List<String>> get favoriteLibraryIdsNotifier => _favoriteLibraryIdsNotifier;

  final _librariesRepository = GetIt.I.get<LibrariesRepository>();
  final _appLogger = AppLogger();
  final _isOpenNowFilterNotifier = ValueNotifier<bool>(false);
  final _sortOptionNotifier = ValueNotifier<SortOption>(SortOption.rating);
  final _sortedLibrariesNotifier = ValueNotifier<List<LibraryModel>>([]);
  final _favoriteLibraryIdsNotifier = ValueNotifier<List<String>>([]);

  Future _init() {
    return Future.wait([
      _initFavoriteLibraryIds(),
      _initSortOption(),
    ]);
  }

  void dispose() {
    _isOpenNowFilterNotifier.dispose();
    _sortOptionNotifier.dispose();
    _sortedLibrariesNotifier.dispose();
    _favoriteLibraryIdsNotifier.dispose();
  }

  Future reset() {
    _appLogger.logMessage('[LibrariesUserPreferencesService]: Resetting user preferences');
    return Future.wait([
      _librariesRepository.deleteAllLocalData(),
      updateSortOption(SortOption.rating),
      Future.value(_favoriteLibraryIdsNotifier.value = []),
    ]);
  }

  Future<void> _initFavoriteLibraryIds() async {
    final favoriteLibraryIds = await _librariesRepository.getFavoriteLibraryIds() ?? [];
    _favoriteLibraryIdsNotifier.value = favoriteLibraryIds;
    _appLogger.logMessage('[LibrariesUserPreferencesService]: Local favorite library ids: $favoriteLibraryIds');

    final librariesCubit = GetIt.I<LibrariesCubit>();
    final librariesCubitState = librariesCubit.state;
    librariesCubit.stream.withInitialValue(librariesCubitState).listen((state) async {
      if (state is LibrariesLoadInProgress && state.libraries != null) {
        sortLibraries(state.libraries!);
      } else if (state is LibrariesLoadSuccess) {
        sortLibraries(state.libraries);
        final retrievedFavoriteLibraryIds =
        state.libraries.where((library) => library.rating.isLiked).map((library) => library.id).toList();
        _appLogger
            .logMessage('[LibrariesUserPreferencesService]: Retrieved favorite library ids: $retrievedFavoriteLibraryIds');

        final unsyncedFavoriteLibraryIds =
        favoriteLibraryIds.where((id) => !retrievedFavoriteLibraryIds.contains(id)).toList();

        final unsyncedUnfavoriteLibraryIds =
        retrievedFavoriteLibraryIds.where((id) => !favoriteLibraryIds.contains(id)).toList();

        final missingSyncLibraryIds = unsyncedFavoriteLibraryIds + unsyncedUnfavoriteLibraryIds;
        for (final missingSyncLibraryId in missingSyncLibraryIds) {
          await _librariesRepository.toggleFavoriteLibraryId(missingSyncLibraryId);
        }
      }
    });
  }

  Future<void> updateFavoriteLibrariesOrder(List<String> favoriteIds) async {
    _favoriteLibraryIdsNotifier.value = favoriteIds;
    await _librariesRepository.saveFavoriteLibraryIds(favoriteIds);
  }

  Future<void> toggleFavoriteLibraryId(String id, {int? insertIndex}) async {
    final favoriteLibraryIds = List<String>.from(_favoriteLibraryIdsNotifier.value);

    if (favoriteLibraryIds.contains(id)) {
      favoriteLibraryIds.remove(id);
    } else {
      favoriteLibraryIds.insert(insertIndex ?? favoriteLibraryIds.length, id);
    }

    _favoriteLibraryIdsNotifier.value = favoriteLibraryIds;
    await _librariesRepository.saveFavoriteLibraryIds(favoriteLibraryIds);
    await _librariesRepository.toggleFavoriteLibraryId(id);
  }

  void sortLibraries(List<LibraryModel> libraries) {
    final sortedLibraries = _sortOptionNotifier.value.sort(libraries);
    if (listEquals(sortedLibraries, _sortedLibrariesNotifier.value)) {
      return;
    }
    _sortedLibrariesNotifier.value = sortedLibraries;
  }

  Future<void> _initSortOption() async {
    final loadedSortOption = await _librariesRepository.getSortOption();

    if (loadedSortOption != null) {
      _sortOptionNotifier.value = loadedSortOption;
    }
  }

  Future<void> updateSortOption(SortOption sortOption) async {
    await _librariesRepository.setSortOption(sortOption);
  }
}
