import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

abstract class BaseTile extends StatelessWidget {
  const BaseTile({super.key});

  Widget buildTile(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(LmuSizes.size_4),
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: BorderRadius.circular(
          LmuSizes.size_8,
        ),
      ),
      child: buildTile(context),
    );
  }
}

class LmuContentTile extends BaseTile {
  const LmuContentTile({
    required this.content,
    super.key,
  });

  final List<Widget> content;

  @override
  Widget buildTile(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: content,
    );
  }
}
