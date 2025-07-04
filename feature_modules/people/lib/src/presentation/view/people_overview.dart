import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/people.dart';
import '../component/person_list_item.dart';
import '../viewmodel/people_overview_driver.dart';

class PeopleOverview extends DrivableWidget<PeopleOverviewDriver> {
  PeopleOverview({super.key, required this.facultyId});

  final int facultyId;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    try {
      if (driver.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      final people = driver.people;
      if (people.isEmpty) {
        return Center(
          child: LmuText.body('Keine Personen gefunden'),
        );
      }

      // Einfachste mögliche Liste ohne Gruppierung
      return Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: LmuContentTile(
          contentList: people
              .map((person) => PersonListItem(
                    person: person,
                    onTap: () => _onPersonTapped(person),
                  ))
              .toList(),
        ),
      );
    } catch (e) {
      return Center(
        child: LmuText.body('Fehler beim Laden der Daten'),
      );
    }
  }

  void _onPersonTapped(People person) {
    try {
      driver.onPersonPressed(person);
    } catch (e) {
    }
  }

  @override
  WidgetDriverProvider<PeopleOverviewDriver> get driverProvider => $PeopleOverviewDriverProvider(facultyId: facultyId);
}
