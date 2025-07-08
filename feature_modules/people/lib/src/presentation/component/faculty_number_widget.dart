import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class FacultyNumberWidget extends StatelessWidget {
  const FacultyNumberWidget({
    super.key,
    required this.facultyId,
  });

  final int facultyId;

  @override
  Widget build(BuildContext context) {
    final String formattedNumber = facultyId.toString().padLeft(2, '0');

    return Container(
      width: LmuSizes.size_48,
      height: LmuSizes.size_48,
      decoration: ShapeDecoration(
        color: context.colors.neutralColors.backgroundColors.mediumColors.base,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(LmuSizes.size_6),
        ),
      ),
      child: Center(child: LmuText.h2(formattedNumber)),
    );
  }
}
