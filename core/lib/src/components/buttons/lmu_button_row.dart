import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/widgets.dart';

class LmuButtonRow extends StatelessWidget {
  const LmuButtonRow({super.key, required this.buttons});

  final List<LmuButton> buttons;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: LmuSizes.size_8,
          children: buttons,
        ),
      ),
    );
  }
}
