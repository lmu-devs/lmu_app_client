import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/model/course_model.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final CourseModel course;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: course.name,
      hasFavoriteStar: true,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      hasDivider: true,
      customSubtitle: Padding(
        padding: const EdgeInsets.only(top: LmuSizes.size_12),
        child: Wrap(
          spacing: LmuSizes.size_4,
          runSpacing: LmuSizes.size_4,
          children: [
            if (course.degree != null && course.degree! != "-")
              LmuInTextVisual.text(title: course.degree!),
            if (course.type != "n/a")
              LmuInTextVisual.text(title: course.type),
            LmuInTextVisual.text(title: course.language),
            if (course.sws != null)
              LmuInTextVisual.text(title: '${course.sws!} SWS'),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
