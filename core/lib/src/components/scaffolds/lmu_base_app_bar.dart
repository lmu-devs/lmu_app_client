import 'dart:math';
import 'dart:ui';

import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

class LmuBaseAppBar extends StatefulWidget {
  const LmuBaseAppBar({
    Key? key,
    required this.body,
    required this.largeTitle,
    this.collapsedTitle,
    this.leadingWidget,
    this.trailingWidget,
    this.backgroundColor,
    this.largeTitleTrailingWidget,
    this.collapsedTitleHeight,
    this.alwaysShowCollapsedTitle = false,
    this.stretch = true,
    this.scrollController,
    this.onRefresh,
    this.appBarWidth = 393,
    required this.textTheme,
  }) : super(key: key);

  final Widget body;

  final String largeTitle;
  final String? collapsedTitle;

  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Widget? largeTitleTrailingWidget;

  final Color? backgroundColor;
  final double? collapsedTitleHeight;
  final bool alwaysShowCollapsedTitle;
  final bool stretch;

  final ScrollController? scrollController;
  final void Function()? onRefresh;

  final double appBarWidth;
  final LmuTextTheme textTheme;

  @override
  State<LmuBaseAppBar> createState() => _LmuBaseAppBarState();
}

class _LmuBaseAppBarState extends State<LmuBaseAppBar> {
  late ScrollController _scrollController;
  final _scrollOffsetNotifier = ValueNotifier<double>(0);

  double _calculatedLargeTitleHeight = 0;
  int _maxLines = 0;

  @override
  void initState() {
    super.initState();

    final span = TextSpan(
      text: _largeTitle,
      style: widget.textTheme.h0,
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr, maxLines: 3);
    tp.layout(maxWidth: widget.appBarWidth - LmuSizes.xxlarge);
    _maxLines = min(tp.computeLineMetrics().length, 3);

    const largeTitleLineHeight = 36.0;
    _calculatedLargeTitleHeight = largeTitleLineHeight * _maxLines;

    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      _scrollOffsetNotifier.value = offset;
    });
  }

  String get _largeTitle => widget.largeTitle;
  String get _collapsedTitle => widget.collapsedTitle ?? _largeTitle;

  Widget? get _leadingWidget => widget.leadingWidget;
  Widget? get _trailingWidget => widget.trailingWidget;
  Widget? get _largeTitleTrailingWidget => widget.largeTitleTrailingWidget;

  bool get _alwaysShowCollapsedTitle => widget.alwaysShowCollapsedTitle;
  bool get _stretch => widget.stretch;

  double get _collapsedTitleHeight => widget.collapsedTitleHeight ?? 40.0;
  double get _largeTitleHeight => _calculatedLargeTitleHeight + LmuSizes.medium;
  double get _appBarHeight => _collapsedTitleHeight + _largeTitleHeight;
  double get _maxScrollHeight => 3000.0;

  Color get _backgroundColor => widget.backgroundColor ?? Colors.transparent;

  double _mapValueToRange(double x, double min, double max) {
    double mappedValue = (x - min) / (max - min);
    return mappedValue.clamp(0.0, 1.0);
  }

  SystemUiOverlayStyle _calculateOverlayStyle() {
    final bool isDark = _backgroundColor.computeLuminance() < 0.179;
    final Brightness newBrightness = isDark ? Brightness.dark : Brightness.light;
    final SystemUiOverlayStyle overlayStyle;
    switch (newBrightness) {
      case Brightness.dark:
        overlayStyle = SystemUiOverlayStyle.light;
        break;
      case Brightness.light:
        overlayStyle = SystemUiOverlayStyle.dark;
        break;
    }
    return overlayStyle;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final textStyles = widget.textTheme;
    final titleStyle = textStyles.h3;
    final largeTitleStyle = textStyles.h0;

    final overlayStyle = _calculateOverlayStyle();

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: SnapScrollPhysics(
            parent: BouncingScrollPhysics(),
            snaps: [
              Snap.avoidZone(0, _largeTitleHeight),
              Snap.avoidZone(_largeTitleHeight, 2 * _largeTitleHeight),
            ],
          ),
          slivers: [
            SliverOverlapAbsorber(
              handle: SliverOverlapAbsorberHandle(),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: topPadding + _appBarHeight,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: widget.body,
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: _scrollOffsetNotifier,
          builder: (context, scrollOffset, _) {
            final fullAppBarHeight = clampDouble(
              topPadding + _appBarHeight - scrollOffset,
              _collapsedTitleHeight + topPadding,
              _stretch ? _maxScrollHeight : topPadding + _appBarHeight,
            );
            final scrolledLargeTitleHeight = scrollOffset > 0
                ? clampDouble(_largeTitleHeight - (scrollOffset), 0, _largeTitleHeight)
                : _largeTitleHeight;
            final scaleTitle = !_stretch
                ? 1.0
                : scrollOffset < 0
                    ? clampDouble((1 - scrollOffset / (_maxScrollHeight / 2)), 1, 1.12)
                    : 1.0;
            final middleTextOpacity = _alwaysShowCollapsedTitle
                ? 1.0
                : _mapValueToRange(scrollOffset, LmuSizes.mediumSmall, _largeTitleHeight);

            return Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: fullAppBarHeight,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: overlayStyle.statusBarColor,
                  statusBarBrightness: overlayStyle.statusBarBrightness,
                  statusBarIconBrightness: overlayStyle.statusBarIconBrightness,
                  systemStatusBarContrastEnforced: overlayStyle.systemStatusBarContrastEnforced,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: _collapsedTitleHeight + topPadding,
                        child: SafeArea(
                          bottom: false,
                          child: NavigationToolbar(
                            leading: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: LmuSizes.mediumLarge,
                              ),
                              child: _leadingWidget,
                            ),
                            middle: Opacity(
                              opacity: middleTextOpacity,
                              child: Text(
                                _collapsedTitle,
                                style: titleStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: LmuSizes.mediumLarge,
                              ),
                              child: _trailingWidget,
                            ),
                            middleSpacing: 6.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
                        child: SizedBox(
                          height: scrolledLargeTitleHeight,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: LmuSizes.small,
                                left: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Transform.scale(
                                        scale: scaleTitle,
                                        filterQuality: FilterQuality.high,
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          _largeTitle,
                                          style: largeTitleStyle,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    if (_largeTitleTrailingWidget != null) _largeTitleTrailingWidget!,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
