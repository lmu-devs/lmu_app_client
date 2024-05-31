import 'package:core/constants.dart';
import 'package:core/src/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TitleAlignment { top, center }

class LmuListItem extends StatelessWidget {
  const LmuListItem._({
    Key? key,
    this.title,
    this.titleTextColor,
    this.titleInTextVisuals,
    this.titleAlignment = TitleAlignment.top,
    this.subtitleInTextVisuals,
    this.subtitle,
    this.leadingArea,
    this.trailingArea,
    this.onTap,
  }) : super(key: key);

  final String? title;
  final Color? titleTextColor;
  final List<LmuInTextVisual>? titleInTextVisuals;
  final List<LmuInTextVisual>? subtitleInTextVisuals;
  final String? subtitle;
  final Widget? leadingArea;
  final Widget? trailingArea;
  final void Function()? onTap;
  final TitleAlignment? titleAlignment;

  factory LmuListItem.base({
    Key? key,
    String? title,
    TitleAlignment? titleAlignment,
    Color? titleTextColor,
    List<LmuInTextVisual>? titleInTextVisuals,
    List<LmuInTextVisual>? subtitleInTextVisuals,
    String? subtitle,
    void Function()? onTap,
    Widget? leadingArea,
    Widget? trailingArea,
  }) =>
      LmuListItem._(
        title: title,
        titleAlignment: titleAlignment,
        titleTextColor: titleTextColor,
        titleInTextVisuals: titleInTextVisuals,
        subtitleInTextVisuals: subtitleInTextVisuals,
        subtitle: subtitle,
        leadingArea: leadingArea,
        trailingArea: trailingArea,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(LmuSizes.medium),
        child: Row(
          crossAxisAlignment: subtitle == null && titleAlignment == TitleAlignment.center
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (leadingArea != null)
              Row(
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
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: subtitle == null && titleAlignment == TitleAlignment.center
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  if (title != null || titleInTextVisuals != null)
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: LmuSizes.xlarge,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Flexible(
                              child: LmuText.body(
                                title,
                                color: titleTextColor,
                              ),
                            ),
                          if (titleInTextVisuals != null)
                            ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 24),
                              child: Row(
                                children: _getPaddedInTextVisuals(
                                  inTextVisuals: titleInTextVisuals!,
                                  noPaddingOnFirstElement: title == null,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (subtitle != null || subtitleInTextVisuals != null)
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: LmuSizes.xlarge,
                      ),
                      child: Row(
                        children: [
                          if (subtitle != null)
                            LmuText.body(
                              subtitle!,
                            ),
                          if (subtitleInTextVisuals != null)
                            ..._getPaddedInTextVisuals(
                              inTextVisuals: subtitleInTextVisuals!,
                              noPaddingOnFirstElement: subtitle == null,
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (trailingArea != null)
              Row(
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
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPaddedInTextVisuals({
    required List<LmuInTextVisual> inTextVisuals,
    bool noPaddingOnFirstElement = false,
  }) {
    final List<Widget> paddedVisuals = [];
    for (int i = 0; i < inTextVisuals.length; i++) {
      final isFirst = i == 0;
      final noPadding = noPaddingOnFirstElement && isFirst;
      paddedVisuals.add(
        Padding(
          padding: EdgeInsets.only(left: noPadding ? LmuSizes.none : LmuSizes.small),
          child: inTextVisuals[i],
        ),
      );
    }
    return paddedVisuals;
  }
}
