import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../carousels/lmu_image_carousel.dart';
import 'leading_action.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const SliverAppBarDelegate({
    required this.largeTitle,
    required this.largeTitleTextStyle,
    required this.largeTitleMaxLines,
    required this.largeTitleHeight,
    this.largeTitleTrailingWidget,
    required this.largeTitleTrailingWidgetAlignment,
    required this.collapsedTitle,
    required this.collapsedTitleTextStyle,
    required this.collapsedTitleHeight,
    this.leadingAction,
    this.onLeadingActionTap,
    this.trailingWidgets,
    this.imageUrls,
    this.customLargeTitleWidget,
    required this.topPadding,
    required this.backgroundColor,
    required this.scrollController,
    required this.scrollOffsetNotifier,
  });

  final String largeTitle;
  final TextStyle largeTitleTextStyle;
  final int largeTitleMaxLines;
  final double largeTitleHeight;
  final Widget? largeTitleTrailingWidget;
  final MainAxisAlignment largeTitleTrailingWidgetAlignment;
  final Widget? customLargeTitleWidget;
  final String collapsedTitle;
  final TextStyle collapsedTitleTextStyle;
  final double collapsedTitleHeight;
  final LeadingAction? leadingAction;
  final void Function()? onLeadingActionTap;
  final List<Widget>? trailingWidgets;
  final List<String>? imageUrls;
  final ScrollController scrollController;
  final ValueNotifier<double> scrollOffsetNotifier;

  final double topPadding;
  final Color backgroundColor;

  final imageHeight = 267.0;
  final largeTitlePadding = 16.0;

  bool get _hasImage => imageUrls?.isNotEmpty ?? false;
  double get _imageSize => _hasImage ? imageHeight : 0.0;
  double get imageOffset => !_hasImage ? 0.0 : _imageSize - collapsedTitleHeight - topPadding + largeTitlePadding;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrolledLargeTitleHeight = _calculateLargeTitleHeight(shrinkOffset);
    final collapsedOpacity = _calculateMiddleOpacity(shrinkOffset);
    final imageOpacity = _calculateImageOpacity(shrinkOffset);
    final scrolledImageHeight = _calculateImageHeight(shrinkOffset);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor),
        child: Stack(
          children: [
            if (_hasImage)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: imageOpacity,
                  child: _ImageSection(
                    scrolledImageHeight: scrolledImageHeight,
                    imageUrls: imageUrls,
                    imageHeight: imageHeight,
                    scrollOffsetNotifier: scrollOffsetNotifier,
                  ),
                ),
              ),
            Positioned(
              top: topPadding,
              left: 0,
              right: 0,
              height: collapsedTitleHeight,
              child: _CollapsedToolbar(
                collapsedTitle: collapsedTitle,
                collapsedTitleTextStyle: collapsedTitleTextStyle,
                collapsedOpacity: collapsedOpacity,
                leadingAction: leadingAction,
                onLeadingActionTap: onLeadingActionTap,
                hasImage: _hasImage,
                backgroundColor: backgroundColor,
                trailingWidgets: trailingWidgets,
              ),
            ),
            Positioned(
              top: topPadding + collapsedTitleHeight,
              left: 0,
              right: 0,
              child: _PullToRefresh(
                scrollOffsetNotifier: scrollOffsetNotifier,
              ),
            ),
            Positioned(
              bottom: LmuSizes.size_4,
              left: 0,
              right: 0,
              height: scrolledLargeTitleHeight,
              child: _LargeTitle(
                largeTitle: largeTitle,
                largeTitleTextStyle: largeTitleTextStyle,
                largeTitleMaxLines: largeTitleMaxLines,
                largeTitleTrailingWidgetAlignment: largeTitleTrailingWidgetAlignment,
                largeTitleTrailingWidget: largeTitleTrailingWidget,
                scrollOffsetNotifier: scrollOffsetNotifier,
                hasImage: _hasImage,
                customLargeTitleWidget: customLargeTitleWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SystemUiOverlayStyle get _overlayStyle {
    final bool isDark = backgroundColor.computeLuminance() < 0.179;
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

    return SystemUiOverlayStyle(
      statusBarColor: overlayStyle.statusBarColor,
      statusBarBrightness: overlayStyle.statusBarBrightness,
      statusBarIconBrightness: overlayStyle.statusBarIconBrightness,
      systemStatusBarContrastEnforced: overlayStyle.systemStatusBarContrastEnforced,
    );
  }

  double _calculateLargeTitleHeight(double scrollOffset) {
    if (scrollOffset > 0 + imageOffset) {
      return clampDouble(largeTitleHeight - scrollOffset + imageOffset, 0, largeTitleHeight);
    }
    return largeTitleHeight;
  }

  double _calculateImageOpacity(double scrollOffset) {
    final min = imageOffset - largeTitlePadding;
    final max = imageHeight / 3;
    final mappedValue = (scrollOffset - min) / (max - min);
    return mappedValue.clamp(0.0, 1.0);
  }

  double _calculateImageHeight(double scrollOffset) {
    if (scrollOffset > 0) {
      return clampDouble(_imageSize - scrollOffset, 0, _imageSize);
    }
    return _imageSize;
  }

  double _calculateMiddleOpacity(double scrollOffset) {
    final min = LmuSizes.size_16 + imageOffset;
    final max = largeTitleHeight + imageOffset;
    final mappedValue = (scrollOffset - min) / (max - min);
    return mappedValue.clamp(0.0, 1.0);
  }

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => OverScrollHeaderStretchConfiguration();

  @override
  double get maxExtent => collapsedTitleHeight + topPadding + largeTitleHeight + imageOffset;

  @override
  double get minExtent => collapsedTitleHeight + topPadding;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is SliverAppBarDelegate &&
        (oldDelegate.largeTitle != largeTitle ||
            oldDelegate.largeTitleTextStyle != largeTitleTextStyle ||
            oldDelegate.largeTitleMaxLines != largeTitleMaxLines ||
            oldDelegate.largeTitleHeight != largeTitleHeight ||
            oldDelegate.largeTitleTrailingWidget != largeTitleTrailingWidget ||
            oldDelegate.largeTitleTrailingWidgetAlignment != largeTitleTrailingWidgetAlignment ||
            oldDelegate.customLargeTitleWidget != customLargeTitleWidget ||
            oldDelegate.collapsedTitle != collapsedTitle ||
            oldDelegate.collapsedTitleTextStyle != collapsedTitleTextStyle ||
            oldDelegate.collapsedTitleHeight != collapsedTitleHeight ||
            oldDelegate.leadingAction != leadingAction ||
            oldDelegate.onLeadingActionTap != onLeadingActionTap ||
            !const IterableEquality().equals(oldDelegate.trailingWidgets, trailingWidgets) ||
            !const IterableEquality().equals(oldDelegate.imageUrls, imageUrls) ||
            oldDelegate.topPadding != topPadding ||
            oldDelegate.backgroundColor != backgroundColor ||
            oldDelegate.scrollController != scrollController ||
            oldDelegate.scrollOffsetNotifier != scrollOffsetNotifier);
  }
}

class _PullToRefresh extends StatelessWidget {
  const _PullToRefresh({
    required this.scrollOffsetNotifier,
  });

  final ValueNotifier<double> scrollOffsetNotifier;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); //TODO
  }
}

class _CollapsedToolbar extends StatelessWidget {
  const _CollapsedToolbar({
    required this.leadingAction,
    required this.hasImage,
    required this.backgroundColor,
    required this.onLeadingActionTap,
    required this.collapsedOpacity,
    required this.collapsedTitle,
    required this.collapsedTitleTextStyle,
    required this.trailingWidgets,
  });

  final String collapsedTitle;
  final TextStyle collapsedTitleTextStyle;
  final double collapsedOpacity;
  final LeadingAction? leadingAction;
  final void Function()? onLeadingActionTap;
  final List<Widget>? trailingWidgets;
  final bool hasImage;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NavigationToolbar(
          leading: leadingAction != null
              ? _LeadingAction(
                  leadingAction: leadingAction!,
                  hasImage: hasImage,
                  backgroundColor: backgroundColor,
                  onLeadingActionTap: onLeadingActionTap,
                )
              : null,
          middle: Opacity(
            opacity: collapsedOpacity,
            child: Text(
              collapsedTitle,
              style: collapsedTitleTextStyle,
              maxLines: 1,
              textScaler: TextScaler.noScaling,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: trailingWidgets != null
              ? _TrailingActions(
                  trailingWidgets: trailingWidgets,
                  hasImage: hasImage,
                  backgroundColor: backgroundColor,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: collapsedOpacity,
            child: Container(
              height: 1,
              color: context.colors.neutralColors.borderColors.seperatorLight,
            ),
          ),
        )
      ],
    );
  }
}

class _LargeTitle extends StatelessWidget {
  const _LargeTitle({
    required this.largeTitle,
    required this.largeTitleTextStyle,
    required this.largeTitleMaxLines,
    required this.largeTitleTrailingWidgetAlignment,
    required this.largeTitleTrailingWidget,
    required this.scrollOffsetNotifier,
    required this.hasImage,
    this.customLargeTitleWidget,
  });

  final String largeTitle;
  final TextStyle largeTitleTextStyle;
  final int largeTitleMaxLines;
  final MainAxisAlignment largeTitleTrailingWidgetAlignment;
  final Widget? customLargeTitleWidget;
  final Widget? largeTitleTrailingWidget;
  final ValueNotifier<double> scrollOffsetNotifier;
  final bool hasImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Stack(
        children: [
          Positioned(
            bottom: LmuSizes.size_8,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: largeTitleTrailingWidgetAlignment,
                    children: [
                      Flexible(
                        child: customLargeTitleWidget ??
                            ValueListenableBuilder<double>(
                              valueListenable: scrollOffsetNotifier,
                              builder: (context, offset, _) {
                                double scale = 1.0;
                                if (offset < 0 &&
                                    !hasImage &&
                                    largeTitleTrailingWidgetAlignment == MainAxisAlignment.spaceBetween) {
                                  scale = clampDouble((1 - offset / 3000), 1, 1.12);
                                }
                                return Transform.scale(
                                  scale: scale,
                                  filterQuality: FilterQuality.high,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    largeTitle,
                                    style: largeTitleTextStyle,
                                    maxLines: largeTitleMaxLines,
                                    overflow: TextOverflow.ellipsis,
                                    textScaler: TextScaler.noScaling,
                                  ),
                                );
                              },
                            ),
                      ),
                      if (largeTitleTrailingWidget != null)
                        Padding(
                          padding: const EdgeInsets.only(left: LmuSizes.size_12),
                          child: largeTitleTrailingWidget,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({
    required this.scrolledImageHeight,
    required this.imageUrls,
    required this.imageHeight,
    required this.scrollOffsetNotifier,
  });

  final double scrolledImageHeight;
  final List<String>? imageUrls;
  final double imageHeight;
  final ValueNotifier<double> scrollOffsetNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: scrollOffsetNotifier,
      builder: (context, offset, _) {
        double dynamicHeight = scrolledImageHeight;
        if (offset < 0) {
          dynamicHeight = scrolledImageHeight - offset;
        }
        return SizedBox(
          height: dynamicHeight,
          child: LmuImageCarousel(
            imageUrls: imageUrls!,
            height: imageHeight,
          ),
        );
      },
    );
  }
}

class _LeadingAction extends StatelessWidget {
  const _LeadingAction({
    required LeadingAction leadingAction,
    required bool hasImage,
    required Color backgroundColor,
    this.onLeadingActionTap,
  })  : _hasImage = hasImage,
        _backgroundColor = backgroundColor,
        _leadingAction = leadingAction;

  final bool _hasImage;
  final Color _backgroundColor;
  final LeadingAction? _leadingAction;
  final void Function()? onLeadingActionTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onLeadingActionTap != null) {
          onLeadingActionTap!.call();
          return;
        }
        Navigator.of(context).pop();
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _hasImage ? LmuSizes.size_12 : LmuSizes.size_16,
          vertical: LmuSizes.size_2,
        ),
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
        horizontal: _hasImage ? LmuSizes.size_12 : LmuSizes.size_16,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _trailingWidgets!
            .mapIndexed(
              (index, element) => Container(
                margin: EdgeInsets.only(left: index == 0 ? 0 : LmuSizes.size_8),
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
