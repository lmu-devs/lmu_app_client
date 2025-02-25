import 'package:collection/collection.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../cubit/sports_cubit/cubit.dart';
import '../repository/api/models/sports_model.dart';

enum SportsFilterOption { all, available, upcoming }

class SportsStateService {
  final sportsCubit = GetIt.I.get<SportsCubit>();

  final ValueNotifier<Map<String, List<SportsModel>>> _filteredGroupedSportsNotifier = ValueNotifier({});
  ValueNotifier<Map<String, List<SportsModel>>> get filteredGroupedSportsNotifier => _filteredGroupedSportsNotifier;

  final _filterOptionsNotifier = ValueNotifier({
    SportsFilterOption.all: true,
    SportsFilterOption.available: false,
    SportsFilterOption.upcoming: false,
  });
  ValueNotifier<Map<SportsFilterOption, bool>> get filterOptionsNotifier => _filterOptionsNotifier;

  Map<String, List<SportsModel>> _initialValue = {};
  void init() {
    sportsCubit.stream.withInitialValue(sportsCubit.state).listen(
      (state) {
        if (state is SportsLoadSuccess) {
          _initialValue = groupBy(state.sports, (sport) => sport.title[0].toUpperCase());
          _filteredGroupedSportsNotifier.value = _initialValue;
        }
      },
    );
  }

  void searchValues(List<String> values, bool nothingFound) {
    if (nothingFound) {
      _filteredGroupedSportsNotifier.value = {};
      return;
    }
    if (values.isEmpty) {
      _filteredGroupedSportsNotifier.value = _initialValue;
      return;
    }
    _filteredGroupedSportsNotifier.value = _initialValue.entries.fold<Map<String, List<SportsModel>>>(
      {},
      (acc, entry) {
        final key = entry.key;
        final value = entry.value;

        final filteredValue = value.where((sport) {
          final title = sport.title.toLowerCase();
          return values.any((value) => title.contains(value.toLowerCase()));
        }).toList();

        if (filteredValue.isNotEmpty) {
          acc[key] = filteredValue;
        }

        return acc;
      },
    );
  }

  void _updateFilteredSports() {
    final currentFilterOptions = _filterOptionsNotifier.value;
    final currentAllValue = currentFilterOptions[SportsFilterOption.all]!;
    final currentAvailableValue = currentFilterOptions[SportsFilterOption.available]!;
    final currentUpcomingValue = currentFilterOptions[SportsFilterOption.upcoming]!;

    final filteredSports = _initialValue.entries.fold<Map<String, List<SportsModel>>>(
      {},
      (acc, entry) {
        final key = entry.key;
        final value = entry.value;

        final filteredValue = value.where((sport) {
          final currentDate = DateTime.now();

          if (currentAllValue) {
            return true;
          } else if (currentAvailableValue) {
            return sport.courses.any((course) => course.isAvailable);
          } else if (currentUpcomingValue) {
            final startDate = sport.courses.any((course) => currentDate.isBefore(DateTime.parse(course.startDate)));
            final endDate = sport.courses.any((course) => currentDate.isBefore(DateTime.parse(course.endDate)));
            return startDate && endDate;
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
    final currentUpcomingValue = currentFilterOptions[SportsFilterOption.upcoming]!;

    switch (filterOption) {
      case SportsFilterOption.all:
        if (!currentAllValue) {
          _filterOptionsNotifier.value = {
            SportsFilterOption.all: true,
            SportsFilterOption.available: false,
            SportsFilterOption.upcoming: false,
          };
        }
        break;

      case SportsFilterOption.available:
        if (currentAvailableValue) {
          _filterOptionsNotifier.value = {
            SportsFilterOption.all: currentUpcomingValue ? false : true,
            SportsFilterOption.available: false,
            SportsFilterOption.upcoming: currentUpcomingValue,
          };
        } else {
          _filterOptionsNotifier.value = {
            SportsFilterOption.all: false,
            SportsFilterOption.available: true,
            SportsFilterOption.upcoming: currentUpcomingValue,
          };
        }
        break;

      case SportsFilterOption.upcoming:
        if (currentUpcomingValue) {
          _filterOptionsNotifier.value = {
            SportsFilterOption.all: currentAvailableValue ? false : true,
            SportsFilterOption.available: currentAvailableValue,
            SportsFilterOption.upcoming: false,
          };
        } else {
          _filterOptionsNotifier.value = {
            SportsFilterOption.all: false,
            SportsFilterOption.available: currentAvailableValue,
            SportsFilterOption.upcoming: true,
          };
        }

        break;
      default:
    }

    _updateFilteredSports();
  }
}
