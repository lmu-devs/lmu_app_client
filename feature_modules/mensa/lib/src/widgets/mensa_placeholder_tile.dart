import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';

class MensaPlaceholderTile extends StatelessWidget {
  const MensaPlaceholderTile({super.key, required this.content});

  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return DashedBorderContainer(
      width: double.infinity,
      borderRadius: LmuRadiusSizes.mediumLarge,
      borderColor: context.colors.neutralColors.backgroundColors.strongColors.base,
      dashWidth: 7.5,
      dashSpace: 7.5,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.mediumLarge),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: LmuSizes.xsmall,
            runSpacing: LmuSizes.xsmall,
            children: content,
          ),
        ),
      ),
    );
  }
}
