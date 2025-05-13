import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/{{feature_name.snakeCase()}}_page_driver.dart';
import '../component/{{feature_name.snakeCase()}}_card.dart';

class {{feature_name.pascalCase()}}Page extends DrivableWidget<{{feature_name.pascalCase()}}PageDriver> {
  {{feature_name.pascalCase()}}Page({super.key});

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
            key: ValueKey("{{feature_name.snakeCase()}}_page_${driver.isLoading}"),
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
        {{feature_name.pascalCase()}}Card(
          id: driver.{{feature_name.snakeCase()}}Id,
          title: driver.title,
          description: driver.description,
          onTap: driver.on{{feature_name.pascalCase()}}CardPressed,
        ),
      ],
    );
  }

  @override
  WidgetDriverProvider<{{feature_name.pascalCase()}}PageDriver> get driverProvider => ${{feature_name.pascalCase()}}PageDriverProvider();
}