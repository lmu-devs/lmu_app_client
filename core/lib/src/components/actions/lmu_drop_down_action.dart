import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

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
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0.5).animate(_controller);

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
    final color = context.colors.neutralColors.textColors.mediumColors.base;
    return RotationTransition(
      turns: _animation,
      child: LmuIcon(
        icon: Icons.keyboard_arrow_down,
        size: LmuIconSizes.medium,
        color: color,
      ),
    );
  }
}
