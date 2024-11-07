import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuHeader extends StatelessWidget {
  const LmuHeader({
    super.key,
    this.leadingIcon,
    this.onLeadingTap,
    this.title,
    this.trailingIcon,
    this.onTrailingTap,
    this.showExpanded = false,
    this.traillingWidget,
  });

  final IconData? leadingIcon;
  final void Function()? onLeadingTap;
  final String? title;
  final IconData? trailingIcon;
  final void Function()? onTrailingTap;
  final bool showExpanded;
  final Widget? traillingWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: showExpanded ? LmuSizes.xxlarge : LmuSizes.xxxlarge,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 28,
                child: leadingIcon != null
                    ? GestureDetector(
                        onTap: onLeadingTap,
                        child: LmuIcon(
                          icon: leadingIcon!,
                          size: 28,
                          color: context.colors.neutralColors.textColors.strongColors.base,
                        ),
                      )
                    : null,
              ),
              if (title != null && !showExpanded) LmuText.h3(title),
              traillingWidget != null
                  ? traillingWidget!
                  : SizedBox(
                      width: 28,
                      child: trailingIcon != null
                          ? GestureDetector(
                              onTap: onTrailingTap,
                              child: LmuIcon(
                                icon: trailingIcon!,
                                size: 28,
                                color: context.colors.neutralColors.textColors.strongColors.base,
                              ),
                            )
                          : null),
            ],
          ),
        ),
        if (title != null && showExpanded)
          SizedBox(
            height: LmuSizes.xxxlarge,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LmuText.h1(title),
              ],
            ),
          ),
      ],
    );
  }
}
