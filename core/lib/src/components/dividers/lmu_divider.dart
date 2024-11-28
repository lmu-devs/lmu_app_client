import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuDivider extends StatelessWidget {
  const LmuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.5,
      height: 0.5,
      color: context.colors.neutralColors.borderColors.seperatorLight,
    );
  }
}
