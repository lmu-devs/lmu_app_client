import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/people_card.dart';
import '../viewmodel/people_overview_driver.dart';

class PeopleOverview extends DrivableWidget<PeopleOverviewDriver> {
  PeopleOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: LmuPageAnimationWrapper(
          child: Align(
            key: ValueKey("people_page_${driver.isLoading}"),
            alignment: Alignment.topCenter,
            child: content,
          ),
        ),
      ),
    );
  }

  Widget get content {
    if (driver.isLoading) return const SizedBox.shrink(); // replace with skeleton loading

    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_16),
        PeopleCard(
          id: driver.peopleId,
          title: driver.title,
          description: driver.description,
          onTap: driver.onPeopleCardPressed,
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<PeopleOverviewDriver> get driverProvider => $PeopleOverviewDriverProvider();
}
