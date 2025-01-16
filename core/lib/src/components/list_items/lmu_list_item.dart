import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

enum MainContentAlignment { top, center }

class LmuListItem extends StatelessWidget {
  const LmuListItem._({
    Key? key,
    this.title,
    this.titleColor,
    this.titleInTextVisuals,
    this.mainContentAlignment = MainContentAlignment.center,
    this.subtitle,
    this.subtitleColor,
    this.subtitleInTextVisuals,
    this.trailingTitle,
    this.trailingTitleColor,
    this.trailingTitleInTextVisuals,
    this.trailingSubtitle,
    this.trailingSubtitleColor,
    this.trailingSubtitleInTextVisuals,
    this.leadingArea,
    this.trailingArea,
    this.actionType,
    this.onActionValueChanged,
    this.shouldChangeActionValue,
    this.actionValueNotifier,
    this.hasVerticalPadding = true,
    this.hasHorizontalPadding = true,
    this.onTap,
    this.hasDivider = false,
    this.maximizeLeadingTitleArea = false,
    this.maximizeTrailingTitleArea = false,
  }) : super(key: key);

  final String? title;
  final Color? titleColor;
  final List<LmuInTextVisual>? titleInTextVisuals;
  final MainContentAlignment mainContentAlignment;
  final String? subtitle;
  final Color? subtitleColor;
  final List<LmuInTextVisual>? subtitleInTextVisuals;
  final String? trailingTitle;
  final Color? trailingTitleColor;
  final List<LmuInTextVisual>? trailingTitleInTextVisuals;
  final String? trailingSubtitle;
  final Color? trailingSubtitleColor;
  final List<LmuInTextVisual>? trailingSubtitleInTextVisuals;
  final Widget? leadingArea;
  final Widget? trailingArea;
  final LmuListItemAction? actionType;
  final void Function(bool)? onActionValueChanged;
  final bool Function(bool)? shouldChangeActionValue;
  final ValueNotifier<bool>? actionValueNotifier;
  final void Function()? onTap;
  final bool hasVerticalPadding;
  final bool hasHorizontalPadding;
  final bool hasDivider;
  final bool maximizeLeadingTitleArea;
  final bool maximizeTrailingTitleArea;

  factory LmuListItem.base({
    Key? key,
    String? title,
    Color? titleColor,
    List<LmuInTextVisual>? titleInTextVisuals,
    MainContentAlignment? mainContentAlignment,
    String? subtitle,
    Color? subtitleTextColor,
    List<LmuInTextVisual>? subtitleInTextVisuals,
    String? trailingTitle,
    Color? trailingTitleColor,
    List<LmuInTextVisual>? trailingTitleInTextVisuals,
    String? trailingSubtitle,
    Color? trailingSubtitleColor,
    List<LmuInTextVisual>? trailingSubtitleInTextVisuals,
    Widget? leadingArea,
    Widget? trailingArea,
    void Function()? onTap,
    bool? hasVerticalPadding,
    bool? hasHorizontalPadding,
    bool? hasDivider,
    bool? maximizeLeadingTitleArea,
    bool? maximizeTrailingTitleArea,
  }) =>
      LmuListItem._(
        key: key,
        title: title,
        titleColor: titleColor,
        titleInTextVisuals: titleInTextVisuals,
        mainContentAlignment: mainContentAlignment ?? MainContentAlignment.center,
        subtitle: subtitle,
        subtitleColor: subtitleTextColor,
        subtitleInTextVisuals: subtitleInTextVisuals,
        trailingTitle: trailingTitle,
        trailingTitleColor: trailingTitleColor,
        trailingTitleInTextVisuals: trailingTitleInTextVisuals,
        trailingSubtitle: trailingSubtitle,
        trailingSubtitleColor: trailingSubtitleColor,
        trailingSubtitleInTextVisuals: trailingSubtitleInTextVisuals,
        leadingArea: leadingArea,
        trailingArea: trailingArea,
        onTap: onTap,
        hasHorizontalPadding: hasHorizontalPadding ?? true,
        hasVerticalPadding: hasVerticalPadding ?? true,
        hasDivider: hasDivider ?? false,
        maximizeLeadingTitleArea: maximizeLeadingTitleArea ?? false,
        maximizeTrailingTitleArea: maximizeTrailingTitleArea ?? false,
      );

  factory LmuListItem.action({
    required LmuListItemAction actionType,
    void Function(bool)? onChange,
    bool Function(bool)? shouldChange,
    bool? initialValue,
    Key? key,
    String? title,
    Color? titleColor,
    List<LmuInTextVisual>? titleInTextVisuals,
    MainContentAlignment? mainContentAlignment,
    String? subtitle,
    Color? subtitleTextColor,
    List<LmuInTextVisual>? subtitleInTextVisuals,
    String? trailingTitle,
    Color? trailingTitleColor,
    List<LmuInTextVisual>? trailingTitleInTextVisuals,
    String? trailingSubtitle,
    Color? trailingSubtitleColor,
    List<LmuInTextVisual>? trailingSubtitleInTextVisuals,
    Widget? leadingArea,
    Widget? trailingArea,
    void Function()? onTap,
    bool? hasVerticalPadding,
    bool? hasHorizontalPadding,
    bool? hasDivider,
    bool? maximizeLeadingTitleArea,
    bool? maximizeTrailingTitleArea,
  }) {
    return LmuListItem._(
      key: key,
      title: title,
      titleColor: titleColor,
      titleInTextVisuals: titleInTextVisuals,
      mainContentAlignment: mainContentAlignment ?? MainContentAlignment.center,
      subtitle: subtitle,
      subtitleColor: subtitleTextColor,
      subtitleInTextVisuals: subtitleInTextVisuals,
      trailingTitle: trailingTitle,
      trailingTitleColor: trailingTitleColor,
      trailingTitleInTextVisuals: trailingTitleInTextVisuals,
      trailingSubtitle: trailingSubtitle,
      trailingSubtitleColor: trailingSubtitleColor,
      trailingSubtitleInTextVisuals: trailingSubtitleInTextVisuals,
      leadingArea: leadingArea,
      trailingArea: trailingArea,
      actionValueNotifier: ValueNotifier<bool>(initialValue ?? false),
      onActionValueChanged: onChange,
      shouldChangeActionValue: shouldChange,
      hasHorizontalPadding: hasHorizontalPadding ?? true,
      hasVerticalPadding: hasVerticalPadding ?? true,
      actionType: actionType,
      onTap: onTap,
      hasDivider: hasDivider ?? false,
      maximizeLeadingTitleArea: maximizeLeadingTitleArea ?? false,
      maximizeTrailingTitleArea: maximizeTrailingTitleArea ?? false,
    );
  }

  // Helpers
  bool get _hasTitle => title != null;
  bool get _hasTitleInTextVisuals => titleInTextVisuals != null;
  bool get _hasTrailingTitle => trailingTitle != null && actionType != LmuListItemAction.chevron;
  bool get _hasTrailingTitleInTextVisuals => trailingTitleInTextVisuals != null;
  bool get _hasLeadingTitleArea => _hasTitle || _hasTitleInTextVisuals;
  bool get _hasTrailingTitleArea => _hasTrailingTitle || _hasTrailingTitleInTextVisuals;
  bool get _hasTitleLine => _hasLeadingTitleArea || _hasTrailingTitleArea;

  bool get _hasSubtitle => subtitle != null;
  bool get _hasSubtitleInTextVisuals => subtitleInTextVisuals != null;
  bool get _hasTrailingSubtitle => trailingSubtitle != null;
  bool get _hasTrailingSubtitleInTextVisuals => trailingSubtitleInTextVisuals != null;
  bool get _hasLeadingSubtitleArea => _hasSubtitle || _hasSubtitleInTextVisuals;
  bool get _hasTrailingSubtitleArea => _hasTrailingSubtitle || _hasTrailingSubtitleInTextVisuals;
  bool get _hasSubtitleLine => _hasLeadingSubtitleArea || _hasTrailingSubtitleArea;

  bool get _hasMainContent => _hasTitleLine || _hasSubtitleLine;
  bool get _hasLeadingArea => leadingArea != null;
  bool get _hasActionArea => actionType != null && actionValueNotifier != null;
  bool get _hasTrailingArea => trailingArea != null;

  CrossAxisAlignment get _mainContentAlignment =>
      mainContentAlignment == MainContentAlignment.center ? CrossAxisAlignment.center : CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    final defaultSubtitleColor = context.colors.neutralColors.textColors.mediumColors.base;

    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (actionValueNotifier != null) {
              final currentValue = actionValueNotifier!.value;
              if (shouldChangeActionValue?.call(currentValue) ?? true) {
                actionValueNotifier?.value = !currentValue;
                onActionValueChanged?.call(!currentValue);
                onTap?.call();
              }
            } else {
              onTap?.call();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: hasVerticalPadding ? LmuSizes.size_12 : LmuSizes.size_8,
              horizontal: hasHorizontalPadding ? LmuSizes.size_12 : LmuSizes.none,
            ),
            child: Row(
              crossAxisAlignment: _mainContentAlignment,
              children: [
                if (_hasLeadingArea) _LeadingArea(leadingArea: leadingArea),
                if (_hasMainContent)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: _mainContentAlignment,
                      children: [
                        if (_hasLeadingTitleArea || _hasLeadingSubtitleArea)
                          Flexible(
                            flex: maximizeLeadingTitleArea ? 2 : 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_hasLeadingTitleArea)
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_hasTitle)
                                          Flexible(
                                            child: LmuText.body(
                                              title,
                                              color: titleColor,
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                        if (_hasTitleInTextVisuals)
                                          LmuPaddedInTextVisuals(
                                            inTextVisuals: titleInTextVisuals!,
                                            noPaddingOnFirstElement: title == null,
                                          ),
                                      ],
                                    ),
                                  ),
                                if (_hasLeadingSubtitleArea)
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_hasSubtitle)
                                          Flexible(
                                            child: LmuText.body(
                                              subtitle!,
                                              color: subtitleColor ?? defaultSubtitleColor,
                                            ),
                                          ),
                                        if (_hasSubtitleInTextVisuals)
                                          LmuPaddedInTextVisuals(
                                            inTextVisuals: subtitleInTextVisuals!,
                                            noPaddingOnFirstElement: subtitle == null,
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (_hasTrailingTitleArea || _hasTrailingSubtitleArea)
                          Flexible(
                            flex: maximizeTrailingTitleArea ? 2 : 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_hasTrailingTitleArea)
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (_hasTrailingTitleInTextVisuals)
                                          LmuPaddedInTextVisuals(
                                            inTextVisuals: trailingTitleInTextVisuals!,
                                            noPaddingOnFirstElement: trailingTitle == null,
                                            hasPaddingOnRight: true,
                                          ),
                                        if (_hasTrailingTitle)
                                          Flexible(
                                            child: LmuText.body(
                                              trailingTitle,
                                              textAlign: TextAlign.end,
                                              color: trailingTitleColor,
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                if (_hasTrailingSubtitleArea)
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (_hasTrailingSubtitleInTextVisuals)
                                          LmuPaddedInTextVisuals(
                                            inTextVisuals: trailingSubtitleInTextVisuals!,
                                            noPaddingOnFirstElement: trailingSubtitle == null,
                                            hasPaddingOnRight: true,
                                          ),
                                        if (_hasTrailingSubtitle)
                                          Flexible(
                                            child: LmuText.body(
                                              trailingSubtitle!,
                                              textAlign: TextAlign.end,
                                              color: trailingSubtitleColor ?? defaultSubtitleColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                if (_hasActionArea)
                  Padding(
                    padding: EdgeInsets.only(
                      top: (_hasSubtitleLine && _hasTitleLine && mainContentAlignment == MainContentAlignment.top)
                          ? LmuSizes.size_12
                          : LmuSizes.none,
                    ),
                    child: _ActionArea(
                      actionArea: actionType,
                      tappedNotifier: actionValueNotifier,
                      chevronTitle: trailingTitle,
                    ),
                  ),
                if (_hasTrailingArea) _TrailingArea(trailingArea: trailingArea),
              ],
            ),
          ),
        ),
        if (hasDivider) const LmuDivider(),
      ],
    );
  }
}

class _TrailingArea extends StatelessWidget {
  const _TrailingArea({
    required this.trailingArea,
  });

  final Widget? trailingArea;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: LmuSizes.size_16,
        ),
        Center(
          child: trailingArea!,
        ),
        const SizedBox(
          width: LmuSizes.size_4,
        ),
      ],
    );
  }
}

class _ActionArea extends StatelessWidget {
  const _ActionArea({
    required this.actionArea,
    required this.tappedNotifier,
    this.chevronTitle,
  });

  final LmuListItemAction? actionArea;
  final ValueNotifier<bool>? tappedNotifier;
  final String? chevronTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: chevronTitle != null ? 0 : LmuSizes.size_16,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: LmuSizes.size_48,
            minHeight: LmuSizes.size_24,
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: tappedNotifier!,
            builder: (context, isActive, _) {
              return actionArea!.getWidget(isActive: isActive, chevronTitle: chevronTitle);
            },
          ),
        ),
      ],
    );
  }
}

class _LeadingArea extends StatelessWidget {
  const _LeadingArea({
    required this.leadingArea,
  });

  final Widget? leadingArea;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: leadingArea!,
        ),
        const SizedBox(
          width: LmuSizes.size_16,
        )
      ],
    );
  }
}
