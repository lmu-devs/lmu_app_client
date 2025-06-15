import 'dart:math';

import 'package:core/constants.dart';
import 'package:core/src/components/components.dart';
import 'package:core/src/components/scaffolds/sliver_app_bar_delegate.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LmuScaffold extends StatefulWidget {
  const LmuScaffold({
    super.key,
    required this.appBar,
    this.body,
    this.floatingActionButton,
    this.slivers,
    this.customScrollController,
    this.onPopInvoked,
    this.isBottomSheet = false,
    this.bottomNavigationBar,
  });

  final LmuAppBarData appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final List<Widget>? slivers;
  final ScrollController? customScrollController;
  final Future<bool> Function()? onPopInvoked;
  final bool isBottomSheet;
  final Widget? bottomNavigationBar;

  @override
  State<LmuScaffold> createState() => _LmuScaffoldState();
}

class _LmuScaffoldState extends State<LmuScaffold> {
  final double _largeTitleLineHeight = 36;
  final double _defaultCollapsedTitleHeight = 44;
  final double _bottomeSheetCollapsedTitleHeight = 54;

  late final ValueNotifier<double> _scrollOffsetNotifier;
  late final ScrollController _scrollController;

  LmuAppBarData get _appBar => widget.appBar;
  String get _largeTitle => _appBar.largeTitle ?? ' ';
  double get _collapsedTitleHeight =>
      widget.isBottomSheet ? _bottomeSheetCollapsedTitleHeight : _defaultCollapsedTitleHeight;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.customScrollController ?? ScrollController();
    _scrollOffsetNotifier = ValueNotifier(0.0);
    _scrollController.addListener(() {
      _scrollOffsetNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollOffsetNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final backgroundColor = context.colors.neutralColors.backgroundColors.base;
    final textTheme = context.textTheme;
    final largeTitleTextTheme = textTheme.h0;
    final collapsedTitleTextStyle = textTheme.h3;
    final largeTitleMaxLines = _calculateTitleMaxLines(_largeTitle, largeTitleTextTheme, mediaQuery.size.width);
    final calculatedLargeTitleHeight = largeTitleMaxLines * _largeTitleLineHeight + LmuSizes.size_16;

    return Material(
      child: WillPopScope(
        onWillPop: widget.onPopInvoked,
        child: Scaffold(
          bottomNavigationBar: widget.bottomNavigationBar,
          backgroundColor: backgroundColor,
          body: CupertinoScrollbar(
            controller: _scrollController,
            mainAxisMargin: widget.isBottomSheet ? _bottomeSheetCollapsedTitleHeight : 3,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    largeTitle: _largeTitle,
                    largeTitleTextStyle: largeTitleTextTheme,
                    largeTitleMaxLines: largeTitleMaxLines,
                    largeTitleHeight: calculatedLargeTitleHeight,
                    customLargeTitleWidget: _appBar.customLargeTitleWidget,
                    collapsedTitle: _appBar.collapsedTitle ?? _largeTitle,
                    collapsedTitleTextStyle: collapsedTitleTextStyle,
                    collapsedTitleHeight: _collapsedTitleHeight,
                    topPadding: mediaQuery.padding.top,
                    backgroundColor: backgroundColor,
                    largeTitleTrailingWidget: _appBar.largeTitleTrailingWidget,
                    largeTitleTrailingWidgetAlignment: _appBar.largeTitleTrailingWidgetAlignment,
                    leadingAction: _appBar.leadingAction,
                    onLeadingActionTap: _appBar.onLeadingActionTap,
                    trailingWidgets: _appBar.trailingWidgets,
                    imageUrls: _appBar.imageUrls,
                    scrollOffsetNotifier: _scrollOffsetNotifier,
                  ),
                ),
                if (widget.slivers != null) ...widget.slivers!,
                if (widget.body != null) SliverToBoxAdapter(child: widget.body),
              ],
            ),
          ),
          floatingActionButton: widget.floatingActionButton,
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

// P2R could be based on this
// PinnedHeaderSliver(
//   child: ValueListenableBuilder(
//     valueListenable: _scrollOffsetNotifier,
//     builder: (context, offset, child) {
//       print("offset: $offset");
//       final opacity = offset > 11 ? 0.0 : 1.0;
//       return Opacity(
//         opacity: opacity,
//         child: Container(
//           color: Colors.red,
//           height: mediaQuery.padding.top + _collapsedTitleHeight,
//           child: child,
//         ),
//       );
//     },
//   ),
// ),
