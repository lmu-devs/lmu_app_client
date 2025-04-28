import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuDivider extends StatelessWidget {
  const LmuDivider({super.key, this.height = 1.0});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: height,
      height: height,
      color: context.colors.neutralColors.borderColors.seperatorLight,
    );
  }
}
