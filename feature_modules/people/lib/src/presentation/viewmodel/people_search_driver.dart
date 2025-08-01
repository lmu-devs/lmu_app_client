import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_people_usecase.dart';
import '../../domain/model/people.dart';

part 'people_search_driver.g.dart';

class PeopleSearchEntry extends SearchEntry {
  final People person;
  
  const PeopleSearchEntry({
    required super.title,
    required this.person,
  });
}

@GenerateTestDriver()
class PeopleSearchDriver extends WidgetDriver implements _$DriverProvidedProperties {
  PeopleSearchDriver({
    @driverProvidableProperty required int facultyId,
  }) : _facultyId = facultyId;

  late int _facultyId;
  int get facultyId => _facultyId;

  final _usecase = GetIt.I.get<GetPeopleUsecase>();
  final _recentSearchController = LmuRecentSearchController<PeopleSearchEntry>();

  List<People> _recentSearches = [];
  List<People> get recentSearches => _recentSearches;

  LmuRecentSearchController<PeopleSearchEntry> get recentSearchController => _recentSearchController;

  List<People> get people => _usecase.data;

  List<People> get facultyPeople => people.where((person) => person.facultyId == facultyId).toList();

  String get pageTitle => _localizations.app.search;

  List<PeopleSearchEntry> get searchEntries => people
      .map((person) => PeopleSearchEntry(
            title: '${person.name} ${person.surname}',
            person: person,
          ))
      .toList();

  List<PeopleSearchEntry> get recentSearchEntries => _recentSearches
      .map((person) => PeopleSearchEntry(
            title: '${person.name} ${person.surname}',
            person: person,
          ))
      .toList();

  List<PeopleSearchEntry> get recommendedEntries {
    final recommended = people.take(4).toList();
    return recommended
        .map((person) => PeopleSearchEntry(
              title: '${person.name} ${person.surname}',
              person: person,
            ))
        .toList();
  }

  void onPersonPressed(BuildContext context, People person) {
    PeopleDetailsRoute(facultyId: facultyId, personId: person.id).push(context);
  }

  void updateRecentSearch(List<PeopleSearchEntry> recentSearchEntries) {
    _recentSearches = recentSearchEntries.map((entry) => entry.person).toList();
    // TODO: Save to SharedPreferences later
  }

  @override
  void didUpdateProvidedProperties({
    required int newFacultyId,
  }) {
    _facultyId = newFacultyId;
  }
}
