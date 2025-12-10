import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../domain/model/course_model.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
    this.hasDivider = true,
  });

  static Widget loading() => const _CourseCardLoading();

  final CourseModel course;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return LmuCard(
      title: course.name,
      hasFavoriteStar: true,
      isFavorite: isFavorite,
      onFavoriteTap: onFavoriteTap,
      hasDivider: hasDivider,
      customSubtitle: Padding(
        padding: const EdgeInsets.only(top: LmuSizes.size_12),
        child: Wrap(
          spacing: LmuSizes.size_4,
          runSpacing: LmuSizes.size_4,
          children: [
            if (course.degree != null && course.degree! != "-")
              LmuInTextVisual.text(title: course.degree!),
            if (course.type != "n/a") LmuInTextVisual.text(title: course.type),
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

class _CourseCardLoading extends StatelessWidget {
  const _CourseCardLoading();

  @override
  Widget build(BuildContext context) {
    return LmuSkeleton(
      child: LmuCard(
        title: BoneMock.title,
        hasFavoriteStar: true,
        hasDivider: true,
        customSubtitle: Padding(
          padding: const EdgeInsets.only(top: LmuSizes.size_12),
          child: Wrap(
            spacing: LmuSizes.size_4,
            runSpacing: LmuSizes.size_4,
            children: [
              LmuInTextVisual.text(title: BoneMock.words(1)),
              LmuInTextVisual.text(title: BoneMock.words(1)),
              LmuInTextVisual.text(title: BoneMock.words(1)),
              LmuInTextVisual.text(title: BoneMock.words(1)),
            ],
          ),
        ),
        onTap: () => {},
      ),
    );
  }
}
