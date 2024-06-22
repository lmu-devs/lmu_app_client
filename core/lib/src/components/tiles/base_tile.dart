import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

abstract class BaseTile extends StatelessWidget {
  const BaseTile({super.key});

  Widget buildTile(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(LmuSizes.small),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: BorderRadius.circular(
          LmuSizes.mediumSmall,
        ),
      ),
      child: buildTile(context),
    );
  }
}
