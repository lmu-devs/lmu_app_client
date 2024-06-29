import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../actions/actions.dart';
import '../in_text_visuals/in_text_visuals.dart';
import '../texts/lmu_text.dart';

enum MainContentAlignment { top, center }

class LmuListItem extends StatelessWidget {
  const LmuListItem._({
    Key? key,
    this.title,
    this.titleColor,
    this.titleInTextVisuals,
    this.mainContentAlignment = MainContentAlignment.top,
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
    this.actionArea,
    this.onActionValueChanged,
    this.actionValueNotifier,
    this.hasVerticalPadding = true,
    this.hasHorizontalPadding = true,
    this.onTap,
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
  final Widget? actionArea;
  final void Function(bool)? onActionValueChanged;
  final ValueNotifier<bool>? actionValueNotifier;
  final void Function()? onTap;
  final bool hasVerticalPadding;
  final bool hasHorizontalPadding;

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
  }) =>
      LmuListItem._(
        key: key,
        title: title,
        titleColor: titleColor,
        titleInTextVisuals: titleInTextVisuals,
        mainContentAlignment: mainContentAlignment ?? MainContentAlignment.top,
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
      );

  factory LmuListItem.toggle({
    required void Function(bool) onChange,
    required bool initialValue,
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
    bool? hasVerticalPadding,
    bool? hasHorizontalPadding,
  }) {
    final tappedNotifier = ValueNotifier<bool>(initialValue);
    return LmuListItem._(
      key: key,
      title: title,
      titleColor: titleColor,
      titleInTextVisuals: titleInTextVisuals,
      mainContentAlignment: mainContentAlignment ?? MainContentAlignment.top,
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
      actionValueNotifier: tappedNotifier,
      onActionValueChanged: onChange,
      hasHorizontalPadding: hasHorizontalPadding ?? true,
      hasVerticalPadding: hasVerticalPadding ?? true,
      actionArea: ValueListenableBuilder<bool>(
        valueListenable: tappedNotifier,
        builder: (context, isActive, _) {
          return LmuToggleAction(
            isActive: isActive,
          );
        },
      ),
    );
  }

  factory LmuListItem.dropdown({
    required void Function(bool) onChange,
    required bool initialValue,
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
    bool? hasVerticalPadding,
    bool? hasHorizontalPadding,
  }) {
    final tappedNotifier = ValueNotifier<bool>(initialValue);
    return LmuListItem._(
      key: key,
      title: title,
      titleColor: titleColor,
      titleInTextVisuals: titleInTextVisuals,
      mainContentAlignment: mainContentAlignment ?? MainContentAlignment.top,
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
      actionValueNotifier: tappedNotifier,
      onActionValueChanged: onChange,
      hasHorizontalPadding: hasHorizontalPadding ?? true,
      hasVerticalPadding: hasVerticalPadding ?? true,
      actionArea: ValueListenableBuilder<bool>(
        valueListenable: tappedNotifier,
        builder: (context, isActive, _) {
          return LmuDropDownAction(
            isActive: isActive,
          );
        },
      ),
    );
  }

  factory LmuListItem.checkbox({
    required void Function(bool) onChange,
    required bool initialValue,
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
    bool? hasVerticalPadding,
    bool? hasHorizontalPadding,
  }) {
    final tappedNotifier = ValueNotifier<bool>(initialValue);
    return LmuListItem._(
      key: key,
      title: title,
      titleColor: titleColor,
      titleInTextVisuals: titleInTextVisuals,
      mainContentAlignment: mainContentAlignment ?? MainContentAlignment.top,
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
      actionValueNotifier: tappedNotifier,
      onActionValueChanged: onChange,
      hasHorizontalPadding: hasHorizontalPadding ?? true,
      hasVerticalPadding: hasVerticalPadding ?? true,
      actionArea: ValueListenableBuilder<bool>(
        valueListenable: tappedNotifier,
        builder: (context, isActive, _) {
          return LmuCheckboxAction(
            isActive: isActive,
          );
        },
      ),
    );
  }

  // Helpers
  bool get _hasTitle => title != null;
  bool get _hasTitleInTextVisuals => titleInTextVisuals != null;

  bool get _hasTrailingTitle => trailingTitle != null;
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
  bool get _hasActionArea => actionArea != null;
  bool get _hasTrailingArea => trailingArea != null;

  MainAxisAlignment get _mainContentAlignment =>
      mainContentAlignment == MainContentAlignment.center ? MainAxisAlignment.center : MainAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    final defaultSubtitleColor = context.colors.neutralColors.textColors.mediumColors.base;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onTap?.call();
        if (actionValueNotifier != null) {
          final currentValue = actionValueNotifier!.value;
          actionValueNotifier?.value = !currentValue;
          onActionValueChanged?.call(!currentValue);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: hasVerticalPadding ? LmuSizes.medium : LmuSizes.mediumSmall,
          horizontal: hasHorizontalPadding ? LmuSizes.medium : LmuSizes.none,
        ),
        child: Row(
          crossAxisAlignment: mainContentAlignment == MainContentAlignment.center
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (_hasLeadingArea) _LeadingArea(leadingArea: leadingArea),
            if (_hasMainContent)
              Expanded(
                child: Column(
                  mainAxisAlignment: _mainContentAlignment,
                  children: [
                    if (_hasTitleLine)
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: LmuSizes.xlarge,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_hasLeadingTitleArea)
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minHeight: LmuSizes.xlarge,
                                        ),
                                        child: LmuPaddedInTextVisuals(
                                          inTextVisuals: titleInTextVisuals!,
                                          noPaddingOnFirstElement: title == null,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            if (_hasLeadingTitleArea && _hasTrailingTitleArea)
                              const SizedBox(
                                width: LmuSizes.mediumLarge,
                              ),
                            if (_hasTrailingTitleArea)
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (_hasTrailingTitleInTextVisuals)
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minHeight: LmuSizes.xlarge,
                                        ),
                                        child: LmuPaddedInTextVisuals(
                                          inTextVisuals: trailingTitleInTextVisuals!,
                                          noPaddingOnFirstElement: trailingTitle == null,
                                          hasPaddingOnRight: true,
                                        ),
                                      ),
                                    if (_hasTrailingTitle)
                                      Flexible(
                                        child: LmuText.body(
                                          trailingTitle,
                                          textAlign: TextAlign.end,
                                          color: trailingTitleColor,
                                        ),
                                      ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    if (_hasSubtitleLine)
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: LmuSizes.xlarge,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_hasLeadingSubtitleArea)
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_hasSubtitle)
                                      Flexible(
                                        child: LmuText.body(
                                          subtitle!,
                                          color: subtitleColor ?? defaultSubtitleColor,
                                        ),
                                      ),
                                    if (_hasSubtitleInTextVisuals)
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minHeight: LmuSizes.xlarge,
                                        ),
                                        child: LmuPaddedInTextVisuals(
                                          inTextVisuals: subtitleInTextVisuals!,
                                          noPaddingOnFirstElement: subtitle == null,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            if (_hasLeadingSubtitleArea && _hasTrailingSubtitleArea)
                              const SizedBox(
                                width: LmuSizes.mediumLarge,
                              ),
                            if (_hasTrailingSubtitleArea)
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (_hasTrailingSubtitleInTextVisuals)
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minHeight: LmuSizes.xlarge,
                                        ),
                                        child: LmuPaddedInTextVisuals(
                                          inTextVisuals: trailingSubtitleInTextVisuals!,
                                          noPaddingOnFirstElement: trailingSubtitle == null,
                                          hasPaddingOnRight: true,
                                        ),
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
            if (_hasActionArea) _ActionArea(actionArea: actionArea),
            if (_hasTrailingArea) _TrailingArea(trailingArea: trailingArea),
          ],
        ),
      ),
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
          width: LmuSizes.mediumLarge,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: LmuSizes.xxxlarge,
            maxHeight: LmuSizes.xxxlarge,
            minHeight: LmuSizes.xxxlarge,
            minWidth: LmuSizes.xxxlarge,
          ),
          child: Center(
            child: trailingArea!,
          ),
        ),
      ],
    );
  }
}

class _ActionArea extends StatelessWidget {
  const _ActionArea({
    required this.actionArea,
  });

  final Widget? actionArea;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: LmuSizes.mediumLarge,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: LmuSizes.xxxlarge,
            maxHeight: LmuSizes.xxxlarge,
            minHeight: LmuSizes.xlarge,
          ),
          child: actionArea,
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
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: LmuSizes.xxxlarge,
            maxHeight: LmuSizes.xxxlarge,
            minHeight: LmuSizes.xxxlarge,
            minWidth: LmuSizes.xxxlarge,
          ),
          child: Center(
            child: leadingArea!,
          ),
        ),
        const SizedBox(
          width: LmuSizes.mediumLarge,
        )
      ],
    );
  }
}
