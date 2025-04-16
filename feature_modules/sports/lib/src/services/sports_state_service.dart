import 'package:collection/collection.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../cubit/sports_cubit/cubit.dart';
import '../extensions/sports_url_constructor_extension.dart';
import '../repository/api/models/sports_favorites.dart';
import '../repository/api/models/sports_type.dart';
import '../repository/sports_repository.dart';

enum SportsFilterOption { all, available }

class SportsStateService {
  final _sportsCubit = GetIt.I.get<SportsCubit>();
  final _sportsRepo = GetIt.I.get<SportsRepository>();

  final ValueNotifier<Map<String, List<SportsType>>> _filteredGroupedSportsNotifier = ValueNotifier({});
  ValueNotifier<Map<String, List<SportsType>>> get filteredGroupedSportsNotifier => _filteredGroupedSportsNotifier;

  final _filterOptionsNotifier = ValueNotifier({SportsFilterOption.all: true, SportsFilterOption.available: false});
  ValueNotifier<Map<SportsFilterOption, bool>> get filterOptionsNotifier => _filterOptionsNotifier;

  final _favoriteSportsCoursesNotifier = ValueNotifier<List<SportsFavorites>>([]);
  ValueNotifier<List<SportsFavorites>> get favoriteSportsCoursesNotifier => _favoriteSportsCoursesNotifier;

  final _isSearchActiveNotifier = ValueNotifier(false);
  ValueNotifier<bool> get isSearchActiveNotifier => _isSearchActiveNotifier;

  Map<String, List<SportsType>> _initialSportTypes = {};

  void init() async {
    _sportsCubit.stream.withInitialValue(_sportsCubit.state).listen(
      (state) {
        if (state is SportsLoadInProgress && state.sports != null) {
          _initialSportTypes = groupBy(state.sports!.sportTypes, (sport) => sport.title[0].toUpperCase());
          _filteredGroupedSportsNotifier.value = _initialSportTypes;
          _baseUrl = state.sports!.baseUrl;
          _sportsRepo.getFavoriteSports().then((value) {
            _favoriteSportsCoursesNotifier.value = value;
          });
        } else if (state is SportsLoadSuccess) {
          _initialSportTypes = groupBy(state.sports.sportTypes, (sport) => sport.title[0].toUpperCase());
          _filteredGroupedSportsNotifier.value = _initialSportTypes;
          _baseUrl = state.sports.baseUrl;
          _sportsRepo.getFavoriteSports().then((value) {
            _favoriteSportsCoursesNotifier.value = value;
          });
        }
      },
    );
  }

  Future<void> toggleFavoriteSport(String courseId, String sportType) async {
    final currentFavorites = List.of(_favoriteSportsCoursesNotifier.value);

    final existingEntry = currentFavorites.firstWhere(
      (entry) => entry.category == sportType,
      orElse: () => SportsFavorites(category: sportType, favorites: const []),
    );

    if (existingEntry.favorites.isNotEmpty) {
      if (existingEntry.favorites.contains(courseId)) {
        existingEntry.favorites.remove(courseId);
        if (existingEntry.favorites.isEmpty) {
          currentFavorites.remove(existingEntry);
        }
      } else {
        existingEntry.favorites.add(courseId);
      }
    } else {
      currentFavorites.add(SportsFavorites(category: sportType, favorites: [courseId]));
    }

    currentFavorites.sort((a, b) => a.category.compareTo(b.category));

    _favoriteSportsCoursesNotifier.value = currentFavorites;
    await _sportsRepo.saveFavoriteSports(currentFavorites);
  }

  String _baseUrl = "";
  String constructUrl(String title) => _baseUrl.constructSportsUrl(title);

  void _updateFilteredSports() {
    final currentFilterOptions = _filterOptionsNotifier.value;
    final currentAllValue = currentFilterOptions[SportsFilterOption.all]!;
    final currentAvailableValue = currentFilterOptions[SportsFilterOption.available]!;

    final filteredSports = _initialSportTypes.entries.fold<Map<String, List<SportsType>>>(
      {},
      (acc, entry) {
        final key = entry.key;
        final value = entry.value;

        final filteredValue = value.where((sport) {
          if (currentAllValue) {
            return true;
          } else if (currentAvailableValue) {
            return sport.courses.any((course) => course.isAvailable);
          }

          return false;
        }).toList();

        if (filteredValue.isNotEmpty) {
          acc[key] = filteredValue;
        }

        return acc;
      },
    );

    _filteredGroupedSportsNotifier.value = filteredSports;
  }

  void applyFilter(SportsFilterOption filterOption) {
    final currentFilterOptions = _filterOptionsNotifier.value;
    final currentAllValue = currentFilterOptions[SportsFilterOption.all]!;
    final currentAvailableValue = currentFilterOptions[SportsFilterOption.available]!;

    _filterOptionsNotifier.value = {
      SportsFilterOption.all: !currentAllValue,
      SportsFilterOption.available: !currentAvailableValue,
    };

    _updateFilteredSports();
  }
}
