import 'package:flutter/material.dart';

class LmuIcon extends StatelessWidget {
  const LmuIcon({
    Key? key,
    required this.icon,
    required this.size,
    this.color,
  }) : super(key: key);

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
