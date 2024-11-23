import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import 'lmu_base_app_bar.dart';

export 'lmu_base_app_bar.dart' show LeadingAction;

class LmuScaffoldWithAppBar extends StatelessWidget {
  const LmuScaffoldWithAppBar({
    super.key,
    required this.body,
    required this.largeTitle,
    this.collapsedTitle,
    this.largeTitleTrailingWidget,
    this.trailingWidget,
    this.leadingAction,
    this.customScrollController,
    this.stretch = true,
    this.collapsedTitleHeight,
    this.imageUrls,
    this.trailingWidgets,
    this.largeTitleTrailingWidgetAlignment = MainAxisAlignment.spaceBetween,
  });

  final Widget body;
  final String largeTitle;
  final String? collapsedTitle;
  final Widget? largeTitleTrailingWidget;
  final Widget? trailingWidget;
  final ScrollController? customScrollController;
  final bool stretch;
  final double? collapsedTitleHeight;
  final List<String>? imageUrls;
  final List<Widget>? trailingWidgets;
  final LeadingAction? leadingAction;
  final MainAxisAlignment largeTitleTrailingWidgetAlignment;

  @override
  Widget build(BuildContext context) {
    final neutralColors = context.colors.neutralColors;
    final width = MediaQuery.of(context).size.width;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: neutralColors.backgroundColors.base,
      body: LmuBaseAppBar(
        body: body,
        largeTitle: largeTitle,
        collapsedTitle: collapsedTitle,
        scrollController: customScrollController,
        stretch: stretch,
        backgroundColor: neutralColors.backgroundColors.base,
        trailingWidget: trailingWidget,
        largeTitleTrailingWidget: largeTitleTrailingWidget,
        collapsedTitleHeight: collapsedTitleHeight,
        appBarWidth: width,
        textTheme: textTheme,
        imageUrls: imageUrls,
        trailingWidgets: trailingWidgets,
        leadingAction: leadingAction,
        largeTitleTrailingWidgetAlignment: largeTitleTrailingWidgetAlignment,
      ),
    );
  }
}
