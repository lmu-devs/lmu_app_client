import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';

class MensaPlaceholderTile extends StatelessWidget {
  const MensaPlaceholderTile({
    super.key,
    required this.content,
    this.minHeight = 40,
  });

  final List<Widget> content;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return DashedBorderContainer(
      width: double.infinity,
      borderRadius: LmuRadiusSizes.mediumLarge,
      borderColor: context.colors.neutralColors.backgroundColors.strongColors.base,
      dashWidth: 7.5,
      dashSpace: 7.5,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: LmuSizes.size_2,
              runSpacing: LmuSizes.size_2,
              children: content,
            ),
          ),
        ),
      ),
    );
  }
}
