import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

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
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: LmuPageAnimationWrapper(
        child: Align(
          alignment: Alignment.topCenter,
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        ..._buildGroupedPeople(context),
        const SizedBox(height: LmuSizes.size_24),
        _buildShowAllFacultiesButton(context),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  List<Widget> _buildGroupedPeople(BuildContext context) {
    final groupedPeople = driver.groupedPeople;
    final List<Widget> widgets = [];

    for (final entry in groupedPeople.entries) {
      final letter = entry.key;
      final peopleInGroup = entry.value;

      widgets.add(
        LmuTileHeadline.base(title: letter),
      );
      widgets.add(
        const SizedBox(height: LmuSizes.size_2),
      );

      widgets.add(
        LmuContentTile(
          contentList: peopleInGroup
              .map((person) => PersonListItem(
                    person: person,
                    onTap: () => driver.onPersonPressed(context, person),
                  ))
              .toList(),
        ),
      );

      widgets.add(
        const SizedBox(height: LmuSizes.size_16),
      );
    }

    return widgets;
  }

  Widget _buildShowAllFacultiesButton(BuildContext context) {
    return LmuContentTile(
      content: LmuListItem.action(
        title: driver.showAllFacultiesText,
        actionType: LmuListItemAction.chevron,
        onTap: () => driver.onShowAllFacultiesPressed(context),
      ),
    );
  }

  @override
  WidgetDriverProvider<PeopleOverviewDriver> get driverProvider => $PeopleOverviewDriverProvider(facultyId: facultyId);
}
