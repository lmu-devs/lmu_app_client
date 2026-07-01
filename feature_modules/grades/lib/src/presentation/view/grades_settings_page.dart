import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/grades_settings_page_driver.dart';

class GradesSettingsPage extends DrivableWidget<GradesSettingsPageDriver> {
  GradesSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.largeTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuTileHeadline.base(title: driver.ectsLabel, customBottomPadding: 4),
            LmuInputField(
              hintText: driver.ectsHint,
              controller: driver.ectsController,
              maxLength: 3,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
              onChanged: driver.onEctsChanged,
            ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<GradesSettingsPageDriver> get driverProvider => $GradesSettingsPageDriverProvider();
}
