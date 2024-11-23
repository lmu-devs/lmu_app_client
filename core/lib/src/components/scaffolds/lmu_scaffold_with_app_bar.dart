import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import 'lmu_base_app_bar.dart';

class LmuScaffoldWithAppBar extends StatelessWidget {
  const LmuScaffoldWithAppBar({
    super.key,
    required this.body,
    required this.largeTitle,
    this.collapsedTitle,
    this.largeTitleTrailingWidget,
    this.trailingWidget,
    this.leadingWidget,
    this.customScrollController,
    this.stretch = true,
    this.collapsedTitleHeight,
    this.onRefresh,
    this.imageUrls,
  });

  final Widget body;
  final String largeTitle;
  final String? collapsedTitle;
  final Widget? largeTitleTrailingWidget;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final ScrollController? customScrollController;
  final bool stretch;
  final double? collapsedTitleHeight;
  final void Function()? onRefresh;
  final List<String>? imageUrls;

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
        leadingWidget: leadingWidget,
        trailingWidget: trailingWidget,
        largeTitleTrailingWidget: largeTitleTrailingWidget,
        collapsedTitleHeight: collapsedTitleHeight,
        onRefresh: onRefresh,
        appBarWidth: width,
        textTheme: textTheme,
        imageUrls: imageUrls,
      ),
    );
  }
}
