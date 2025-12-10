import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../themes.dart';

class LmuListDropdown extends StatefulWidget {
  const LmuListDropdown({
    super.key,
    this.title,
    this.subtitle,
    this.subtitleColor,
    required this.items,
    this.initialValue = false,
    this.duration = const Duration(milliseconds: 300),
    this.hasDivider = false,
    this.trailingSubtitle,
    this.bottomSpacing = 12,
  });

  final String? title;
  final String? subtitle;
  final Color? subtitleColor;
  final List<Widget> items;
  final bool initialValue;
  final Duration duration;
  final bool hasDivider;
  final String? trailingSubtitle;
  final double bottomSpacing;

  @override
  State<LmuListDropdown> createState() => _LmuListDropdownState();
}

class _LmuListDropdownState extends State<LmuListDropdown> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LmuListItem.action(
          hasHorizontalPadding: false,
          title: widget.title,
          subtitle: widget.subtitle,
          subtitleTextColor: widget.subtitleColor,
          initialValue: _isExpanded,
          mainContentAlignment: MainContentAlignment.center,
          actionType: LmuListItemAction.dropdown,
          trailingSubtitle: widget.trailingSubtitle,
          onChange: (value) => setState(() => _isExpanded = value),
        ),
        AnimatedSize(
          duration: widget.duration,
          curve: Curves.easeInOut,
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            switchInCurve: LmuAnimations.slowSmooth,
            switchOutCurve: LmuAnimations.slowSmooth.flipped,
            duration: widget.duration,
            child: _isExpanded
                ? Column(
                    key: const ValueKey<bool>(true),
                    children: [...widget.items, SizedBox(height: widget.bottomSpacing)],
                  )
                : const SizedBox.shrink(
                    key: ValueKey<bool>(false),
                  ),
          ),
        ),
        if (widget.hasDivider) const LmuDivider(),
      ],
    );
  }
}
