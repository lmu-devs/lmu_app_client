import 'dart:ui';

import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
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
    this.largeTitleHeight,
    this.collapsedTitleHeight,
    this.alwaysShowCollapsedTitle = false,
    this.stretch = true,
    this.scrollController,
    this.onRefresh,
  }) : super(key: key);

  final Widget body;

  final String largeTitle;
  final String? collapsedTitle;

  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Widget? largeTitleTrailingWidget;

  final Color? backgroundColor;
  final double? largeTitleHeight;
  final double? collapsedTitleHeight;
  final bool alwaysShowCollapsedTitle;
  final bool stretch;

  final ScrollController? scrollController;
  final void Function()? onRefresh;

  @override
  State<LmuBaseAppBar> createState() => _LmuBaseAppBarState();
}

class _LmuBaseAppBarState extends State<LmuBaseAppBar> {
  late ScrollController _scrollController;
  final _scrollOffsetNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      _scrollOffsetNotifier.value = offset;

      if (offset < _refreshThreshold) {
        //widget.onRefresh?.call();
      }
    });
  }

  double get _refreshThreshold => -100;

  String get _largeTitle => widget.largeTitle;
  String get _collapsedTitle => widget.collapsedTitle ?? _largeTitle;

  Widget? get _leadingWidget => widget.leadingWidget;
  Widget? get _trailingWidget => widget.trailingWidget;
  Widget? get _largeTitleTrailingWidget => widget.largeTitleTrailingWidget;

  bool get _alwaysShowCollapsedTitle => widget.alwaysShowCollapsedTitle;
  bool get _stretch => widget.stretch;

  double get _collapsedTitleHeight => widget.collapsedTitleHeight ?? 40.0;
  double get _largeTitleHeight => widget.largeTitleHeight ?? 48.0;
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

    final textColors = context.colors.neutralColors.textColors;
    final textStyles = getBaseTextTheme("Inter", textColors);
    final titleStyle = textStyles.h3;
    final largeTitleStyle = textStyles.h0;

    final overlayStyle = _calculateOverlayStyle();

    return Stack(
      children: [
        NestedScrollViewPlus(
          controller: _scrollController,
          physics: SnapScrollPhysics(
            parent: const BouncingScrollPhysics(),
            snaps: [
              Snap.avoidZone(0, _largeTitleHeight),
              Snap.avoidZone(_largeTitleHeight, 2 * _largeTitleHeight),
            ],
          ),
          headerSliverBuilder: (_, __) => [
            OverlapAbsorberPlus(
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: topPadding + _appBarHeight,
                ),
              ),
            )
          ],
          body: widget.body,
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
                              padding: const EdgeInsets.only(left: LmuSizes.mediumLarge),
                              child: _leadingWidget,
                            ),
                            middle: Opacity(
                              opacity: middleTextOpacity,
                              child: Text(
                                _collapsedTitle,
                                style: titleStyle,
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: LmuSizes.mediumLarge),
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
                                    Transform.scale(
                                      scale: scaleTitle,
                                      filterQuality: FilterQuality.high,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        _largeTitle,
                                        style: largeTitleStyle,
                                      ),
                                    ),
                                    const Spacer(),
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
