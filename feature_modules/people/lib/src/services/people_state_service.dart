import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import '../domain/model/people.dart';

class PeopleStateService {
  final ValueNotifier<Map<String, List<People>>> _filteredGroupedPeopleNotifier = ValueNotifier({});
  ValueNotifier<Map<String, List<People>>> get filteredGroupedPeopleNotifier => _filteredGroupedPeopleNotifier;

  final _isSearchActiveNotifier = ValueNotifier(false);
  ValueNotifier<bool> get isSearchActiveNotifier => _isSearchActiveNotifier;

  Map<String, List<People>> _initialPeople = {};

  void updatePeople(List<People> people) {
    final sortedPeople = List.of(people)..sort((a, b) => a.basicInfo.lastName.compareTo(b.basicInfo.lastName));
    _initialPeople = groupBy(
      sortedPeople,
      (p) => p.basicInfo.lastName.isNotEmpty ? p.basicInfo.lastName[0].toUpperCase() : '#',
    );
    _filteredGroupedPeopleNotifier.value = _initialPeople;
  }

  void filterPeople(String query) {
    if (query.isEmpty) {
      _filteredGroupedPeopleNotifier.value = _initialPeople;
      return;
    }

    final filteredPeople = _initialPeople.entries.fold<Map<String, List<People>>>(
      {},
      (acc, entry) {
        final key = entry.key;
        final value = entry.value;

        final filteredValue = value.where((person) {
          final fullName = '${person.basicInfo.lastName} ${person.basicInfo.firstName}'.toLowerCase();
          return fullName.contains(query.toLowerCase());
        }).toList();

        if (filteredValue.isNotEmpty) {
          acc[key] = filteredValue;
        }

        return acc;
      },
    );

    _filteredGroupedPeopleNotifier.value = filteredPeople;
  }

  void resetFilter() {
    _filteredGroupedPeopleNotifier.value = _initialPeople;
  }
}
