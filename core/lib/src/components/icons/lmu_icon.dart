import 'package:flutter/material.dart';

class LmuIcon extends StatelessWidget {
  const LmuIcon({
    super.key,
    required this.icon,
    required this.size,
    this.color,
  });

  final double size;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
