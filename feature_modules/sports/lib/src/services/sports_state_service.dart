import 'package:collection/collection.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../cubit/sports_cubit/cubit.dart';
import '../extensions/extensions.dart';
import '../repository/api/models/sports_favorites.dart';
import '../repository/api/models/sports_type.dart';
import '../repository/sports_repository.dart';

enum SportsFilterOption { available, today }

class SportsStateService {
  final _sportsCubit = GetIt.I.get<SportsCubit>();
  final _sportsRepo = GetIt.I.get<SportsRepository>();

  final ValueNotifier<Map<String, List<SportsType>>>
      _filteredGroupedSportsNotifier = ValueNotifier({});

  ValueNotifier<Map<String, List<SportsType>>>
      get filteredGroupedSportsNotifier => _filteredGroupedSportsNotifier;

  final _filterOptionsNotifier = ValueNotifier({
    SportsFilterOption.available: false,
    SportsFilterOption.today: false,
  });

  ValueNotifier<Map<SportsFilterOption, bool>> get filterOptionsNotifier =>
      _filterOptionsNotifier;

  final _favoriteSportsCoursesNotifier =
      ValueNotifier<List<SportsFavorites>>([]);

  ValueNotifier<List<SportsFavorites>> get favoriteSportsCoursesNotifier =>
      _favoriteSportsCoursesNotifier;

  final _isSearchActiveNotifier = ValueNotifier(false);

  ValueNotifier<bool> get isSearchActiveNotifier => _isSearchActiveNotifier;

  Map<String, List<SportsType>> _initialSportTypes = {};

  void init() async {
    _sportsCubit.stream.withInitialValue(_sportsCubit.state).listen(
      (state) {
        if (state is SportsLoadInProgress && state.sports != null) {
          _initialSportTypes = groupBy(state.sports!.sportTypes,
              (sport) => sport.title[0].toUpperCase());
          _updateFilteredSports();
          _sportsRepo.getFavoriteSports().then((value) {
            _favoriteSportsCoursesNotifier.value = value;
          });
        } else if (state is SportsLoadSuccess) {
          _initialSportTypes = groupBy(
              state.sports.sportTypes, (sport) => sport.title[0].toUpperCase());
          _updateFilteredSports();
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
      currentFavorites
          .add(SportsFavorites(category: sportType, favorites: [courseId]));
    }

    currentFavorites.sort((a, b) => a.category.compareTo(b.category));

    _favoriteSportsCoursesNotifier.value = currentFavorites;
    await _sportsRepo.saveFavoriteSports(currentFavorites);
  }

  void _updateFilteredSports() {
    final activeFilters = _filterOptionsNotifier.value;
    final isAvailableFilterActive =
        activeFilters[SportsFilterOption.available] ?? false;
    final isTodayFilterActive =
        activeFilters[SportsFilterOption.today] ?? false;

    if (!isAvailableFilterActive && !isTodayFilterActive) {
      _filteredGroupedSportsNotifier.value = _initialSportTypes;
      return;
    }

    final filteredSports =
        _initialSportTypes.entries.fold<Map<String, List<SportsType>>>(
      {},
      (acc, entry) {
        final key = entry.key;
        final sportsList = entry.value;

        final filteredSportsList = sportsList
            .map((sport) {
              final filteredCourses = sport.courses.where((course) {
                final availableCondition =
                    !isAvailableFilterActive || course.isAvailable;
                final todayCondition = !isTodayFilterActive || course.runsToday;
                return availableCondition && todayCondition;
              }).toList();

              return SportsType(title: sport.title, courses: filteredCourses);
            })
            .where((sport) => sport.courses.isNotEmpty)
            .toList();

        if (filteredSportsList.isNotEmpty) {
          acc[key] = filteredSportsList;
        }

        return acc;
      },
    );

    _filteredGroupedSportsNotifier.value = filteredSports;
  }

  void toggleFilter(SportsFilterOption filterOption) {
    final newFilterState =
        Map<SportsFilterOption, bool>.from(_filterOptionsNotifier.value);
    newFilterState[filterOption] = !(newFilterState[filterOption] ?? false);

    _filterOptionsNotifier.value = newFilterState;
    _updateFilteredSports();
  }

  void resetFilter() {
    _filterOptionsNotifier.value = {
      SportsFilterOption.available: false,
      SportsFilterOption.today: false,
    };
    _updateFilteredSports();
  }
}
