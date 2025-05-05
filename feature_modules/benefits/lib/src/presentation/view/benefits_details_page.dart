import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../components/benefit_card.dart';
import '../viewmodel/benefits_details_page_driver.dart';

class BenefitsDetailsPage extends DrivableWidget<BenefitsDetailsPageDriver> {
  BenefitsDetailsPage({super.key});

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
        itemCount: driver.benefits.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final benefitItem = driver.benefits[index];
          return BenefitCard(
            key: Key("benefit_card_${benefitItem.hashCode}"),
            benefit: benefitItem,
          );
        },
      ),
    );
  }

  @override
  WidgetDriverProvider<BenefitsDetailsPageDriver> get driverProvider => $BenefitsDetailsPageDriverProvider();
}
