import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuDivider extends StatelessWidget {
  const LmuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      height: 1,
      color: context.colors.neutralColors.borderColors.seperatorLight,
    );
  }
}
