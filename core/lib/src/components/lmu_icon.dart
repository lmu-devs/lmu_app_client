import 'package:flutter/material.dart';

class LmuIcon extends StatelessWidget {
  const LmuIcon({
    Key? key,
    required this.size,
    required this.icon,
  }) : super(key: key);

  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
    );
  }
}
