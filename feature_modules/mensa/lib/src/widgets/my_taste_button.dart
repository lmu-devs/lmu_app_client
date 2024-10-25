import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class MyTasteButton extends StatelessWidget {
  const MyTasteButton({super.key, required this.background});

  final Color background;

  @override
  Widget build(BuildContext context) {
    bool? isChecked = false;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.mediumColors.base,
        borderRadius: BorderRadius.circular(LmuSizes.mediumSmall),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: LmuSizes.mediumSmall,
              horizontal: LmuSizes.mediumLarge,
            ),
            child: LmuText.bodySmall("My Taste", weight: FontWeight.w600),
          ),
          VerticalDivider(
            width: 0,
            thickness: 2.5,
            color: background,
          ),
          Checkbox(
            value: true,
            onChanged: (bool? value) => isChecked = value,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return context.colors.brandColors.backgroundColors.nonInvertableColors.base;
                } else {
                  return context.colors.neutralColors.backgroundColors.base;
                }
              },
            ),
            side: MaterialStateBorderSide.resolveWith(
                  (states) =>
                  BorderSide(width: 0.5, color: context.colors.neutralColors.backgroundColors.strongColors.base),
            ),
          ),
        ],
      ),
    );
  }
}