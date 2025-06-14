import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/people_card.dart';
import '../viewmodel/people_details_page_driver.dart';

class PeopleDetailsPage extends DrivableWidget<PeopleDetailsPageDriver> {
  PeopleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.title,
        leadingAction: LeadingAction.back,
      ),
      body: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: LmuSizes.size_16,
          right: LmuSizes.size_16,
          top: LmuSizes.size_16,
          bottom: LmuSizes.size_96,
        ),
        separatorBuilder: (context, index) => const SizedBox(height: LmuSizes.size_12),
        itemCount: driver.peoples.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final peopleItem = driver.peoples[index];
          return PeopleCard(
            key: Key("people_card_${peopleItem.hashCode}"),
            people: peopleItem,
          ); //PeopleCard
        },
      ),
    );
  }

  @override
  WidgetDriverProvider<PeopleDetailsPageDriver> get driverProvider => $PeopleDetailsPageDriverProvider();
}
