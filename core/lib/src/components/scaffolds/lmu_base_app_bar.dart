import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/src/components/carousels/lmu_image_carousel.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snap_scroll_physics/snap_scroll_physics.dart';

enum LeadingAction {
  back,
  close,
}

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
    required this.largeTitleTrailingWidgetAlignment,
    this.collapsedTitleHeight,
    this.alwaysShowCollapsedTitle = false,
    this.stretch = true,
    this.scrollController,
    this.appBarWidth = 393,
    required this.textTheme,
    this.imageUrls,
    this.trailingWidgets,
    this.leadingAction,
  }) : super(key: key);

  final Widget body;
  final String largeTitle;
  final String? collapsedTitle;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Widget? largeTitleTrailingWidget;
  final MainAxisAlignment largeTitleTrailingWidgetAlignment;
  final Color? backgroundColor;
  final double? collapsedTitleHeight;
  final bool alwaysShowCollapsedTitle;
  final bool stretch;
  final ScrollController? scrollController;
  final List<String>? imageUrls;
  final List<Widget>? trailingWidgets;
  final LeadingAction? leadingAction;

  //TODO: Improve retrival of these values
  final double appBarWidth;
  final LmuTextTheme textTheme;

  @override
  State<LmuBaseAppBar> createState() => _LmuBaseAppBarState();
}

class _LmuBaseAppBarState extends State<LmuBaseAppBar> {
  late ScrollController _scrollController;
  late ValueNotifier<double> _scrollOffsetNotifier;

  final _maxScrollHeight = 3000.0;
  final _largeTitleLineHeight = 36.0;
  final _imageHeight = 267.0;

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

    _calculatedLargeTitleHeight = _largeTitleLineHeight * _maxLines;

    _scrollOffsetNotifier = ValueNotifier(0.0);
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      _scrollOffsetNotifier.value = offset;
    });
  }

  String get _largeTitle => widget.largeTitle;
  String get _collapsedTitle => widget.collapsedTitle ?? _largeTitle;

  bool get _hasImage => widget.imageUrls != null;

  Widget? get _largeTitleTrailingWidget => widget.largeTitleTrailingWidget;

  bool get _alwaysShowCollapsedTitle => widget.alwaysShowCollapsedTitle;
  bool get _stretch => widget.stretch;

  double get _collapsedTitleHeight => widget.collapsedTitleHeight ?? 54.0;
  double get _largeTitleHeight => _calculatedLargeTitleHeight + (_hasImage ? LmuSizes.xlarge : LmuSizes.medium);
  double get _appBarHeight => _collapsedTitleHeight + _largeTitleHeight;

  double get _imageSize => widget.imageUrls != null ? _imageHeight : 0.0;

  Color get _backgroundColor => widget.backgroundColor ?? Colors.transparent;

  LeadingAction? get _leadingAction => widget.leadingAction;
  List<Widget>? get _trailingWidgets => widget.trailingWidgets;
  MainAxisAlignment get _largeTitleTrailingWidgetAlignment => widget.largeTitleTrailingWidgetAlignment;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final textStyles = widget.textTheme;
    final titleStyle = textStyles.h3;
    final largeTitleStyle = textStyles.h0;

    final defaultHeight = (_imageSize == 0 ? topPadding + _appBarHeight : _imageSize + _largeTitleHeight);
    final collapsedHeightWithSafeArea = _collapsedTitleHeight + topPadding;
    final imageOffset = !_hasImage ? 0.0 : _imageSize - _collapsedTitleHeight - topPadding;

    final overlayStyle = _calculateOverlayStyle();

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: SnapScrollPhysics(
            parent: const AlwaysScrollableScrollPhysics(),
            snaps: [
              Snap.avoidZone(0 + imageOffset, _largeTitleHeight + imageOffset),
            ],
          ),
          slivers: [
            SliverOverlapAbsorber(
              handle: SliverOverlapAbsorberHandle(),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: defaultHeight,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: widget.body,
            ),
          ],
        ),
        if (widget.imageUrls != null)
          ValueListenableBuilder(
            valueListenable: _scrollOffsetNotifier,
            builder: (context, scrollOffset, _) {
              final scrolledImageHeight = _calculateImageHeight(scrollOffset);
              final largeTitleScale = _calculateLargeTitleScale(
                scrollOffset,
              );
              final backgroundOpacity = _calculateBackgroundOpactiy(scrollOffset, imageOffset);

              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: backgroundOpacity,
                  child: Transform.scale(
                    scale: largeTitleScale,
                    filterQuality: FilterQuality.high,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: scrolledImageHeight,
                      child: LmuImageCarousel(
                        imageUrls: widget.imageUrls!,
                        height: _imageHeight,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ValueListenableBuilder(
          valueListenable: _scrollOffsetNotifier,
          builder: (context, scrollOffset, _) {
            final fullAppBarHeight =
                _calculateFullAppBarHeight(scrollOffset, defaultHeight, collapsedHeightWithSafeArea);
            final scrolledLargeTitleHeight = _calculateLargeTitleHeight(scrollOffset, imageOffset);
            final largeTitleScale = _calculateLargeTitleScale(scrollOffset);
            final middleTextOpacity = _calculateMiddleOpacity(scrollOffset, imageOffset);

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
                    color: _hasImage ? Colors.transparent : _backgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: collapsedHeightWithSafeArea,
                            child: Opacity(
                              opacity: middleTextOpacity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: collapsedHeightWithSafeArea - 1,
                                    color: _backgroundColor,
                                  ),
                                  Container(
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: context.colors.neutralColors.borderColors.seperatorLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: collapsedHeightWithSafeArea,
                            child: SafeArea(
                              bottom: false,
                              child: NavigationToolbar(
                                leading: _leadingAction != null
                                    ? _LeadingAction(
                                        leadingAction: _leadingAction!,
                                        hasImage: _hasImage,
                                        backgroundColor: _backgroundColor,
                                      )
                                    : null,
                                middle: Opacity(
                                  opacity: middleTextOpacity,
                                  child: Text(
                                    _collapsedTitle,
                                    style: titleStyle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: _trailingWidgets != null
                                    ? _TrailingActions(
                                        trailingWidgets: _trailingWidgets!,
                                        hasImage: _hasImage,
                                        backgroundColor: _backgroundColor,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
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
                                      child: Row(
                                        mainAxisAlignment: _largeTitleTrailingWidgetAlignment,
                                        children: [
                                          Transform.scale(
                                            scale: _hasImage ? 1.0 : largeTitleScale,
                                            filterQuality: FilterQuality.high,
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              _largeTitle,
                                              style: largeTitleStyle,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(width: LmuSizes.medium),
                                          if (_largeTitleTrailingWidget != null) _largeTitleTrailingWidget!
                                        ],
                                      ),
                                    ),
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

  double _calculateLargeTitleHeight(double scrollOffset, double imageOffset) {
    if (scrollOffset > 0 + imageOffset) {
      return clampDouble(_largeTitleHeight - scrollOffset + imageOffset, 0, _largeTitleHeight);
    }
    return _largeTitleHeight;
  }

  double _calculateBackgroundOpactiy(double scrollOffset, double imageOffset) {
    if (_alwaysShowCollapsedTitle) {
      return 1.0;
    }
    final min = imageOffset;
    final max = _imageHeight / 3;
    final mappedValue = (scrollOffset - min) / (max - min);
    return mappedValue.clamp(0.0, 1.0);
  }

  double _calculateMiddleOpacity(double scrollOffset, double imageOffset) {
    if (_alwaysShowCollapsedTitle) {
      return 1.0;
    }
    final min = LmuSizes.mediumLarge + imageOffset + (_hasImage ? 10 : 0);
    final max = _largeTitleHeight + imageOffset;
    final mappedValue = (scrollOffset - min) / (max - min);
    return mappedValue.clamp(0.0, 1.0);
  }

  double _calculateLargeTitleScale(double scrollOffset) {
    if (!_stretch) {
      return 1.0;
    }
    if (scrollOffset < 0) {
      return clampDouble((1 - scrollOffset / (_maxScrollHeight / 2)), 1, 1.12);
    }
    return 1.0;
  }

  double _calculateFullAppBarHeight(double scrollOffset, double defaultHeight, double collapsedHeightWithSafeArea) {
    return clampDouble(
      defaultHeight - scrollOffset,
      collapsedHeightWithSafeArea,
      _stretch ? _maxScrollHeight : defaultHeight,
    );
  }

  double _calculateImageHeight(double scrollOffset) {
    if (scrollOffset > 0) {
      return clampDouble(_imageSize - scrollOffset, 0, _imageSize);
    }
    return _imageSize;
  }
}

class _TrailingActions extends StatelessWidget {
  const _TrailingActions({
    required List<Widget>? trailingWidgets,
    required bool hasImage,
    required Color backgroundColor,
  })  : _trailingWidgets = trailingWidgets,
        _hasImage = hasImage,
        _backgroundColor = backgroundColor;

  final List<Widget>? _trailingWidgets;
  final bool _hasImage;
  final Color _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _hasImage ? LmuSizes.medium : LmuSizes.mediumLarge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _trailingWidgets!
            .mapIndexed(
              (index, element) => Container(
                margin: EdgeInsets.only(left: index == 0 ? 0 : LmuSizes.mediumSmall),
                padding: _hasImage ? const EdgeInsets.all(LmuSizes.mediumSmall) : null,
                decoration: _hasImage
                    ? BoxDecoration(
                        color: _backgroundColor,
                        borderRadius: BorderRadius.circular(100),
                      )
                    : null,
                child: element,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LeadingAction extends StatelessWidget {
  const _LeadingAction({
    required LeadingAction leadingAction,
    required bool hasImage,
    required Color backgroundColor,
  })  : _hasImage = hasImage,
        _backgroundColor = backgroundColor,
        _leadingAction = leadingAction;

  final bool _hasImage;
  final Color _backgroundColor;
  final LeadingAction? _leadingAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _hasImage ? LmuSizes.medium : LmuSizes.mediumLarge,
        vertical: LmuSizes.xsmall,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          padding: _hasImage ? const EdgeInsets.all(6) : null,
          decoration: _hasImage
              ? BoxDecoration(
                  color: _backgroundColor,
                  shape: BoxShape.circle,
                )
              : null,
          child: LmuIcon(
            icon: _leadingAction!.icon,
            size: _hasImage ? 24 : 28,
          ),
        ),
      ),
    );
  }
}

extension LeadingActionIconExtension on LeadingAction {
  IconData get icon {
    switch (this) {
      case LeadingAction.back:
        return Icons.arrow_back;
      case LeadingAction.close:
        return Icons.close;
    }
  }
}
