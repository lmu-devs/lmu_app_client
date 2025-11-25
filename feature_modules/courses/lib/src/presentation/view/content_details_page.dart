import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/content_details_page_driver.dart';

class ContentDetailsPage extends DrivableWidget<ContentDetailsPageDriver> {
  ContentDetailsPage({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.pageTitle,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuMarkdownViewer(data: content),
          ],
        ),
      ),
    );
  }

  @override
  WidgetDriverProvider<ContentDetailsPageDriver> get driverProvider =>
      $ContentDetailsPageDriverProvider(content: content);
}
