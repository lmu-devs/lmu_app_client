import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../icons/lmu_icon.dart';

class LmuDropDownAction extends StatefulWidget {
  const LmuDropDownAction({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  State<LmuDropDownAction> createState() => _LmuDropDownActionState();
}

class _LmuDropDownActionState extends State<LmuDropDownAction> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: .5).animate(
      CurvedAnimation(parent: _controller, curve: LmuAnimations.gentle, reverseCurve: LmuAnimations.gentle.flipped),
    );

    if (widget.isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant LmuDropDownAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colors.neutralColors.textColors.weakColors.base;
    return RotationTransition(
      turns: _animation,
      child: LmuIcon(
        icon: LucideIcons.chevron_down,
        size: LmuIconSizes.medium,
        color: color,
      ),
    );
  }
}
