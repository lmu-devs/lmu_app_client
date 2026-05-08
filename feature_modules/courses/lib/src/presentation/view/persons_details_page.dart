import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/extension/person_model_extension.dart';
import '../../domain/model/person_model.dart';
import '../viewmodel/persons_details_page_driver.dart';

class PersonsDetailsPage extends DrivableWidget<PersonsDetailsPageDriver> {
  PersonsDetailsPage({
    super.key,
    required this.persons,
  });

  final List<PersonModel> persons;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.pageTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: LmuContentTile(
          contentList: persons
              .map(
                (person) => LmuListItem.base(
                  title: person.getFullName(),
                  mainContentAlignment: MainContentAlignment.top,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<PersonsDetailsPageDriver> get driverProvider =>
      $PersonsDetailsPageDriverProvider(persons: persons);
}
