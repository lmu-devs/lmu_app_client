import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';

class LmuButtonRow extends StatelessWidget {
  const LmuButtonRow({
    super.key,
    required this.buttons,
    this.controller,
    this.hasHorizontalPadding = true,
  });

  final List<Widget> buttons;
  final ScrollController? controller;
  final bool hasHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: hasHorizontalPadding ? LmuSizes.size_16 : LmuSizes.none,
        ),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: LmuSizes.size_8,
          children: buttons,
        ),
      ),
    );
  }
}
