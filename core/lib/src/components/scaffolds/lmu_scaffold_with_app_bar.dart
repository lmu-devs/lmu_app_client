import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class LmuScaffoldWithAppBar extends StatelessWidget {
  const LmuScaffoldWithAppBar({
    super.key,
    required this.largeTitle,
    required this.body,
    this.collapsedTitle,
    this.largeTitleTrailingWidget,
    this.trailingWidget,
    this.leadingWidget,
    this.customScrollController,
    this.onCollapsed,
    this.stretch = true,
  });

  final String largeTitle;
  final Widget body;
  final String? collapsedTitle;
  final Widget? largeTitleTrailingWidget;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final ScrollController? customScrollController;
  final void Function(bool)? onCollapsed;
  final bool stretch;

  @override
  Widget build(BuildContext context) {
    final neutralColors = context.colors.neutralColors;

    // Necessary for text scalign effect
    final textColors = neutralColors.textColors;
    final textStyles = getBaseTextTheme("Inter", textColors);
    final titleStyle = textStyles.h3;
    final largeTitleStyle = textStyles.h0;

    return Scaffold(
      backgroundColor: neutralColors.backgroundColors.base,
      body: SuperScaffold(
        scrollController: customScrollController,
        onCollapsed: onCollapsed,
        stretch: stretch,
        appBar: SuperAppBar(
          title: Text(
            collapsedTitle ?? largeTitle,
            style: titleStyle,
          ),
          largeTitle: SuperLargeTitle(
            enabled: true,
            height: LmuSizes.xxxlarge,
            largeTitle: largeTitle,
            textStyle: largeTitleStyle,
            actions: [if (largeTitleTrailingWidget != null) largeTitleTrailingWidget!],
          ),
          backgroundColor: neutralColors.backgroundColors.base,
          height: 54, // Adjust for different heights
          actions: trailingWidget != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: LmuSizes.mediumLarge,
                        vertical: 14,
                      ),
                      child: SizedBox(
                        height: 28,
                        child: trailingWidget!,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          leading: leadingWidget != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: LmuSizes.mediumLarge,
                    vertical: 14,
                  ),
                  child: SizedBox(
                    height: 28,
                    child: leadingWidget,
                  ),
                )
              : const SizedBox.shrink(),
          searchBar: SuperSearchBar(
            enabled: false,
            resultBehavior: SearchBarResultBehavior.neverVisible,
          ),
        ),
        body: body,
      ),
    );
  }
}
