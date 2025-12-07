import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../helpers/grades_formatting_extension.dart';
import '../helpers/grades_gradient_set.dart';

class GradesInListGrade extends StatelessWidget {
  const GradesInListGrade({
    super.key,
    required this.grade,
  });

  final double? grade;

  @override
  Widget build(BuildContext context) {
    final gradeColors = context.gradeGradientSet.highlights;

    return Container(
      width: LmuSizes.size_48,
      height: LmuSizes.size_48,
      decoration: ShapeDecoration(
        color: context.colors.neutralColors.backgroundColors.mediumColors.base,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(LmuSizes.size_6),
        ),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(LmuSizes.size_6),
          ),
        ),
        child: Center(
          child: grade != null
              ? Text(
                  grade!.asStringWithOneDecimal,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: gradeColors.interpValue(
                      grade!,
                      min: 1.0,
                      max: 5.0,
                    ),
                  ),
                )
              : Icon(
                  Icons.check,
                  color: context.colors.customColors.textColors.green,
                ),
        ),
      ),
    );
  }
}
