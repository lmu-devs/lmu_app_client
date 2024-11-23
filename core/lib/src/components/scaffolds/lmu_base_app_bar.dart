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
    this.imageUrls,
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

  final List<String>? imageUrls;

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

  double get _imageSize => widget.imageUrls != null ? 250.0 : 0.0;

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

    final defaultHeight = (_imageSize == 0 ? topPadding + _appBarHeight : _imageSize + _largeTitleHeight);
    final collapsedHeightWithSafeArea = _collapsedTitleHeight + topPadding;

    final overlayStyle = _calculateOverlayStyle();

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: SnapScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
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
              final largeTitleScale = _calculateLargeTitleScale(scrollOffset);

              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: largeTitleScale,
                  filterQuality: FilterQuality.high,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: scrolledImageHeight,
                    child: _ImageArea(
                      imageUrls: widget.imageUrls!,
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
            final scrolledLargeTitleHeight = _calculateLargeTitleHeight(scrollOffset);
            final largeTitleScale = _calculateLargeTitleScale(scrollOffset);
            final middleTextOpacity = _calculateMiddleOpacity(scrollOffset);
            final backgroundOpacity = scrolledLargeTitleHeight == _largeTitleHeight ? 0.0 : 1.0;

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
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: collapsedHeightWithSafeArea,
                            child: Opacity(
                              opacity: backgroundOpacity,
                              child: Container(
                                color: _backgroundColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: collapsedHeightWithSafeArea,
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
                                      child: Transform.scale(
                                        scale: largeTitleScale,
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

  double _calculateLargeTitleHeight(double scrollOffset) {
    final test = _imageSize == 0 ? 0 : _imageSize - _collapsedTitleHeight - 59;
    if (scrollOffset > 0 + test) {
      return clampDouble(_largeTitleHeight - scrollOffset + test, 0, _largeTitleHeight);
    }
    return _largeTitleHeight;
  }

  double _calculateMiddleOpacity(double scrollOffset) {
    final test = _imageSize == 0 ? 0 : _imageSize - _collapsedTitleHeight - 59;

    if (_alwaysShowCollapsedTitle) {
      return 1.0;
    }
    return _mapValueToRange(scrollOffset, LmuSizes.mediumSmall + test, _largeTitleHeight + test);
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

class _ImageArea extends StatefulWidget {
  final List<String> imageUrls;

  const _ImageArea({super.key, required this.imageUrls});

  @override
  _ImageAreaState createState() => _ImageAreaState();
}

class _ImageAreaState extends State<_ImageArea> {
  late PageController _pageController;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      int page = _pageController.page?.round() ?? 0;
      if (_currentPageNotifier.value != page) {
        _currentPageNotifier.value = page;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _currentPageNotifier.value = index;
  }

  List<String> get imageUrls => widget.imageUrls;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    if (imageUrls.length == 1) {
      return SoftBlur(
        child: Image.network(
          imageUrls.first,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    }

    return Stack(
      children: [
        PageView.builder(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          clipBehavior: Clip.none,
          controller: _pageController,
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return Image.network(
              imageUrls[index],
              height: 250,
              fit: BoxFit.cover,
            );
          },
        ),
        Positioned(
          bottom: LmuSizes.medium,
          left: 0,
          right: 0,
          child: Center(
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, currentPage, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    imageUrls.length,
                    (index) => GestureDetector(
                      onTap: () => _onDotTapped(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: LmuSizes.small,
                        ),
                        height: LmuSizes.mediumSmall,
                        width: LmuSizes.mediumSmall,
                        decoration: BoxDecoration(
                          color: currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
