import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_people_usecase.dart';
import '../../application/usecase/recent_searches_usecase.dart';
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
  final _recentSearchesUsecase = GetIt.I.get<RecentSearchesUsecase>();

  late LmuLocalizations _localizations;

  List<People> get recentSearches => _recentSearchesUsecase.recentSearches;

  @TestDriverDefaultValue(_TestLmuRecentSearchController())
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

  List<PeopleSearchEntry> get recentSearchEntries => recentSearches
      .map((person) => PeopleSearchEntry(
            title: '${person.name} ${person.surname}',
            person: person,
          ))
      .toList();



  void onPersonPressed(BuildContext context, People person) {
    addRecentSearch(person);
    PeopleDetailsRoute(facultyId: facultyId, personId: person.id).push(context);
  }

  void updateRecentSearch(List<PeopleSearchEntry> recentSearchEntries) {
    if (recentSearchEntries.isEmpty) {
      _recentSearchesUsecase.clearRecentSearches();
    } else {
      for (final entry in recentSearchEntries) {
        _recentSearchesUsecase.addRecentSearch(entry.person);
      }
    }
  }

  Future<void> addRecentSearch(People person) async {
    await _recentSearchesUsecase.addRecentSearch(person);
  }

  void _updateRecentSearchEntries(PeopleSearchEntry input) {
    addRecentSearch(input.person);
  }

  Widget buildSearchEntry(BuildContext context, PeopleSearchEntry entry) {
    final person = entry.person;
    return LmuListItem.action(
      title: '${person.name} ${person.surname}',
      subtitle: person.title.isNotEmpty ? person.title : person.role,
      actionType: LmuListItemAction.chevron,
      onTap: () {
        onPersonPressed(context, person);
        recentSearchController.trigger(entry);
      },
    );
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
    _recentSearchesUsecase.addListener(_onRecentSearchesChanged);
    _recentSearchController.triggerAction = _updateRecentSearchEntries;
  }

  void _onRecentSearchesChanged() {
    notifyWidget();
  }

  @override
  void didUpdateProvidedProperties({
    required int newFacultyId,
  }) {
    _facultyId = newFacultyId;
  }
}

class _TestLmuRecentSearchController extends EmptyDefault implements LmuRecentSearchController<PeopleSearchEntry> {
  const _TestLmuRecentSearchController();
}
