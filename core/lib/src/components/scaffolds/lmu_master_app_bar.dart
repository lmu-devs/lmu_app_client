import 'dart:math';

import 'package:core/constants.dart';
import 'package:core/src/components/scaffolds/sliver_app_bar_delegate.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';

import 'leading_action.dart';

enum CollapsedTitleHeight {
  small,
  large,
}

class LmuMasterAppBar extends StatefulWidget {
  const LmuMasterAppBar({
    super.key,
    required this.largeTitle,
    required this.body,
    this.largeTitleTrailingWidget,
    this.largeTitleTrailingWidgetAlignment = MainAxisAlignment.spaceBetween,
    this.collapsedTitle,
    this.collapsedTitleHeight = CollapsedTitleHeight.small,
    this.leadingAction,
    this.onLeadingActionTap,
    this.trailingWidgets,
    this.imageUrls,
    this.customScrollController,
    this.onPopInvoked,
  });

  final Widget body;
  final String largeTitle;
  final Widget? largeTitleTrailingWidget;
  final MainAxisAlignment largeTitleTrailingWidgetAlignment;
  final String? collapsedTitle;
  final LeadingAction? leadingAction;
  final void Function()? onLeadingActionTap;
  final List<Widget>? trailingWidgets;
  final List<String>? imageUrls;
  final CollapsedTitleHeight collapsedTitleHeight;
  final ScrollController? customScrollController;
  final void Function(bool)? onPopInvoked;

  factory LmuMasterAppBar.bottomSheet({
    Key? key,
    required String largeTitle,
    required Widget body,
    Widget? largeTitleTrailingWidget,
    MainAxisAlignment largeTitleTrailingWidgetAlignment = MainAxisAlignment.spaceBetween,
    String? collapsedTitle,
    void Function()? onLeadingActionTap,
    List<Widget>? trailingWidgets,
    List<String>? imageUrls,
    ScrollController? customScrollController,
    void Function(bool)? onPopInvoked,
  }) {
    return LmuMasterAppBar(
      key: key,
      largeTitle: largeTitle,
      body: body,
      largeTitleTrailingWidget: largeTitleTrailingWidget,
      largeTitleTrailingWidgetAlignment: largeTitleTrailingWidgetAlignment,
      collapsedTitle: collapsedTitle,
      collapsedTitleHeight: CollapsedTitleHeight.large,
      leadingAction: LeadingAction.close,
      onLeadingActionTap: onLeadingActionTap,
      trailingWidgets: trailingWidgets,
      imageUrls: imageUrls,
      customScrollController: customScrollController,
      onPopInvoked: onPopInvoked,
    );
  }

  @override
  State<LmuMasterAppBar> createState() => _LmuMasterAppBarState();
}

class _LmuMasterAppBarState extends State<LmuMasterAppBar> {
  final double _largeTitleLineHeight = 36;
  late ValueNotifier<double> _scrollOffsetNotifier;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.customScrollController ?? ScrollController();
    _scrollOffsetNotifier = ValueNotifier(0.0);
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      if (offset < 0) {
        _scrollOffsetNotifier.value = offset;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollOffsetNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final backgroundColor = context.colors.neutralColors.backgroundColors.base;
    final textTheme = context.textTheme;
    final largeTitleTextTheme = textTheme.h0;
    final collapsedTitleTextStyle = textTheme.h3;
    final largeTitleMaxLines =
        _calculateTitleMaxLines(widget.largeTitle, largeTitleTextTheme, MediaQuery.of(context).size.width);
    final calculatedLargeTitleHeight = largeTitleMaxLines * _largeTitleLineHeight + LmuSizes.size_16;

    return Material(
      child: PopScope(
        onPopInvoked: widget.onPopInvoked,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: NestedScrollViewPlus(
            controller: _scrollController,
            scrollBehavior: const CupertinoScrollBehavior(),
            headerSliverBuilder: (context, innerScrolled) => [
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  largeTitle: widget.largeTitle,
                  largeTitleTextStyle: largeTitleTextTheme,
                  largeTitleMaxLines: largeTitleMaxLines,
                  largeTitleHeight: calculatedLargeTitleHeight,
                  collapsedTitle: widget.collapsedTitle ?? widget.largeTitle,
                  collapsedTitleTextStyle: collapsedTitleTextStyle,
                  collapsedTitleHeight: widget.collapsedTitleHeight == CollapsedTitleHeight.small ? 44 : 54,
                  topPadding: topPadding,
                  backgroundColor: backgroundColor,
                  largeTitleTrailingWidget: widget.largeTitleTrailingWidget,
                  largeTitleTrailingWidgetAlignment: widget.largeTitleTrailingWidgetAlignment,
                  leadingAction: widget.leadingAction,
                  onLeadingActionTap: widget.onLeadingActionTap,
                  trailingWidgets: widget.trailingWidgets,
                  imageUrls: widget.imageUrls,
                  scrollController: _scrollController,
                  scrollOffsetNotifier: _scrollOffsetNotifier,
                ),
              ),
            ],
            body: widget.body,
          ),
        ),
      ),
    );
  }

  int _calculateTitleMaxLines(String largeTitleText, TextStyle largeTitleTextStyle, double maxWidth) {
    final span = TextSpan(text: largeTitleText, style: largeTitleTextStyle);
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr, maxLines: 4);
    tp.layout(maxWidth: maxWidth - LmuSizes.size_32);
    return min(tp.computeLineMetrics().length, 4);
  }
}
