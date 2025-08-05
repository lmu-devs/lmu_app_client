import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:widget_driver/widget_driver.dart';

import '../viewmodel/lecture_detail_page_driver.dart';
import 'lecture_course_content.dart';
import 'lecture_lecturers.dart';
import 'lecture_links.dart';
import 'lecture_more_details.dart';
import 'lecture_study_program.dart';

class LectureDetailPage extends DrivableWidget<LectureDetailPageDriver> {
  LectureDetailPage({
    super.key,
    required this.lectureId,
    required this.lectureTitle,
  });

  final String lectureId;
  final String lectureTitle;

  @override
  WidgetDriverProvider<LectureDetailPageDriver> get driverProvider =>
      _LectureDetailPageDriverProvider(lectureId, lectureTitle);

  @override
  Widget build(BuildContext context) {
    return _buildContent(context, driver);
  }

  Widget _buildContent(BuildContext context, LectureDetailPageDriver driver) {
    if (driver.isLoading) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: driver.loadingText,
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: LmuSizes.size_16),
              Text(driver.loadingText),
            ],
          ),
        ),
      );
    }

    if (driver.hasError) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: 'Error',
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: LmuSizes.size_16),
              Text(driver.errorText),
              const SizedBox(height: LmuSizes.size_16),
              ElevatedButton(
                onPressed: driver.onRetry,
                child: Text(driver.retryText),
              ),
            ],
          ),
        ),
      );
    }

    if (driver.isNotFound) {
      return LmuScaffold(
        appBar: LmuAppBarData(
          largeTitle: 'Not Found',
          leadingAction: LeadingAction.back,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey),
              const SizedBox(height: LmuSizes.size_16),
              Text(driver.lectureNotFoundText),
            ],
          ),
        ),
      );
    }

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.displayLectureTitle,
        leadingAction: LeadingAction.back,
        trailingWidgets: [
          LmuFavoriteButton(
            isFavorite: driver.isFavorite,
            onTap: driver.onFavoriteToggle,
          ),
        ],
      ),
      body: _buildLectureDetailContent(context, driver),
    );
  }

  Widget _buildLectureDetailContent(BuildContext context, LectureDetailPageDriver driver) {
    final lecture = driver.lecture;
    if (lecture == null) return Container();

    final locals = context.locals.lectures;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course metadata tags
          _buildCourseTags(lecture, driver),
          const SizedBox(height: LmuSizes.size_32),

          // Action buttons row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                LmuMapImageButton(
                  onTap: () {},
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuButton(
                  title: lecture.semester ?? locals.winterSemester,
                  size: ButtonSize.medium,
                  emphasis: ButtonEmphasis.secondary,
                  action: ButtonAction.base,
                  state: ButtonState.enabled,
                  trailingIcon: Icons.keyboard_arrow_down,
                  onTap: () {},
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuButton(
                  title: 'LSF',
                  onTap: () {},
                  emphasis: ButtonEmphasis.secondary,
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuButton(
                  title: 'Moodle',
                  onTap: () {},
                  emphasis: ButtonEmphasis.secondary,
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuButton(
                  title: locals.share,
                  onTap: () {},
                  emphasis: ButtonEmphasis.secondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: LmuSizes.size_32),

          // Calendar button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LmuButton(
                title: locals.addToCalendar,
                onTap: () {},
                emphasis: ButtonEmphasis.link,
                size: ButtonSize.large,
                trailingIcon: Icons.event,
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.size_24),

          // Schedule and location card
          _buildScheduleCard(lecture, locals, driver),
          const SizedBox(height: LmuSizes.size_24),

          // Expandable sections
          _buildExpandableSections(context, locals, driver),
          const SizedBox(height: LmuSizes.size_32),

          // Ratings section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LmuText.h3(locals.ratingsTitle),
              LmuButton(
                title: locals.ratingsRate,
                onTap: () {},
                emphasis: ButtonEmphasis.link,
                size: ButtonSize.large,
                action: ButtonAction.base,
                state: ButtonState.disabled,
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.size_24),

          // Average rating tile
          LmuContentTile(
            contentList: [
              LmuListItem.base(
                title: '(${driver.totalRatings})',
                leadingArea: Row(
                  children: [
                    LmuText.body(driver.overallRating.toStringAsFixed(1).replaceAll('.', ',')),
                    const SizedBox(width: LmuSizes.size_8),
                    Row(
                      children: List.generate(5, (index) {
                        final rating = driver.overallRating;
                        if (index < rating.floor()) return StarIcon(isActive: true, size: 20);
                        if (index == rating.floor() && rating % 1 > 0) return StarIcon(isActive: true, size: 20);
                        return StarIcon(isActive: false, size: 20);
                      }),
                    ),
                  ],
                ),
                trailingArea: Icon(
                  driver.isRatingsExpanded ? LucideIcons.chevron_up : LucideIcons.chevron_down,
                  size: 20,
                ),
                onTap: () {
                  driver.onRatingsExpandToggle();
                },
              ),
              // Individual rating items (only show when expanded)
              if (driver.isRatingsExpanded && driver.ratingCategories != null) ...[
                const SizedBox(height: LmuSizes.size_16),
                LmuListItem.base(
                  subtitle: locals.ratingsExplanation,
                  trailingTitle:
                      driver.ratingCategories!['explanation']?.toStringAsFixed(1).replaceAll('.', ',') ?? '3,2',
                  trailingArea: StarIcon(isActive: false, size: 20),
                ),
                LmuListItem.base(
                  subtitle: locals.ratingsMaterials,
                  trailingTitle:
                      driver.ratingCategories!['materials']?.toStringAsFixed(1).replaceAll('.', ',') ?? '3,8',
                  trailingArea: StarIcon(isActive: false, size: 20),
                ),
                LmuListItem.base(
                  subtitle: locals.ratingsEffort,
                  trailingTitle: driver.ratingCategories!['effort']?.toStringAsFixed(1).replaceAll('.', ',') ?? '2,2',
                  trailingArea: StarIcon(isActive: false, size: 20),
                ),
                LmuListItem.base(
                  subtitle: locals.ratingsTeacher,
                  trailingTitle: driver.ratingCategories!['teacher']?.toStringAsFixed(1).replaceAll('.', ',') ?? '4,1',
                  trailingArea: StarIcon(isActive: false, size: 20),
                ),
                LmuListItem.base(
                  subtitle: locals.ratingsExam,
                  trailingTitle: driver.ratingCategories!['exam']?.toStringAsFixed(1).replaceAll('.', ',') ?? '1,2',
                  trailingArea: StarIcon(isActive: false, size: 20),
                ),
              ],
            ],
          ),
          const SizedBox(height: LmuSizes.size_24),

          // Last updated text
          const SizedBox(height: LmuSizes.size_48),
          Center(
            child: LmuText.bodyXSmall(
              locals.lastUpdated('32.12.2023 25:61'),
              color: Colors.grey,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseTags(dynamic lecture, LectureDetailPageDriver driver) {
    final tags = _getTagsForCourse(lecture.title, driver);
    return LmuText.body(
      tags.join(' • '),
      color: Colors.grey,
    );
  }

  List<String> _getTagsForCourse(String courseName, LectureDetailPageDriver driver) {
    // Use API data if available, otherwise fall back to hardcoded tags
    if (driver.hasCourseDetails) {
      final language = driver.courseLanguage;
      final credits = driver.lecture?.credits ?? 6;
      final degree = courseName.toLowerCase().contains('data structures') ? 'Bachelor' : 'Master';
      return ['VL', '$credits SWS', degree, language];
    }

    // Fallback to hardcoded tags
    switch (courseName.toLowerCase()) {
      case 'natural computing':
        return ['VL', '6 SWS', 'Master', 'English'];
      case 'machine learning':
        return ['VL', '8 SWS', 'Master', 'English'];
      case 'data structures & algorithms':
        return ['VL', '6 SWS', 'Bachelor', 'German'];
      default:
        return ['VL', '6 SWS', 'Master', 'English'];
    }
  }

  Widget _buildScheduleCard(dynamic lecture, LecturesLocatizations locals, LectureDetailPageDriver driver) {
    return LmuContentTile(
      contentList: [
        LmuListItem.base(
          subtitle: locals.scheduleTime,
          trailingTitle: driver.scheduleTime,
          maximizeTrailingTitleArea: true,
        ),
        LmuListItem.base(
          subtitle: locals.scheduleDuration,
          trailingTitle: driver.scheduleDuration,
          maximizeTrailingTitleArea: true,
        ),
        LmuListItem.base(
          subtitle: locals.scheduleAddress,
          trailingTitle: driver.scheduleAddress,
          maximizeTrailingTitleArea: true,
          trailingArea: Icon(LucideIcons.map, size: 20),
        ),
        LmuListItem.base(
          subtitle: locals.scheduleRoom,
          trailingTitle: driver.scheduleRoom,
          maximizeTrailingTitleArea: true,
          trailingArea: Icon(LucideIcons.external_link, size: 20),
        ),
      ],
    );
  }

  Widget _buildExpandableSections(BuildContext context, LecturesLocatizations locals, LectureDetailPageDriver driver) {
    return LmuContentTile(
      contentList: [
        LmuListItem.base(
          subtitle: locals.contentTitle,
          trailingArea: Icon(LucideIcons.chevron_right, size: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LectureCourseContent(
                  lectureTitle: driver.lectureTitle,
                ),
              ),
            );
          },
        ),
        LmuListItem.base(
          subtitle: locals.lecturersTitle,
          trailingArea: Icon(LucideIcons.chevron_right, size: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LectureLecturers(
                  lectureTitle: driver.lectureTitle,
                ),
              ),
            );
          },
        ),
        LmuListItem.base(
          subtitle: locals.studyProgramTitle,
          trailingArea: Icon(LucideIcons.chevron_right, size: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LectureStudyProgram(
                  lectureTitle: driver.lectureTitle,
                ),
              ),
            );
          },
        ),
        LmuListItem.base(
          subtitle: locals.moreDetailsTitle,
          trailingArea: Icon(LucideIcons.chevron_right, size: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LectureMoreDetails(
                  lectureTitle: driver.lectureTitle,
                ),
              ),
            );
          },
        ),
        LmuListItem.base(
          subtitle: locals.linksTitle,
          trailingArea: Icon(LucideIcons.chevron_right, size: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LectureLinks(
                  lectureTitle: driver.lectureTitle,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRatingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall rating
        Row(
          children: [
            LmuText.h2('3,8'),
            const SizedBox(width: LmuSizes.size_8),
            Row(
              children: List.generate(5, (index) {
                if (index < 3) return Icon(Icons.star, color: Colors.amber, size: 20);
                if (index == 3) return Icon(Icons.star_half, color: Colors.amber, size: 20);
                return Icon(Icons.star_border, color: Colors.grey, size: 20);
              }),
            ),
            const SizedBox(width: LmuSizes.size_8),
            LmuText.bodySmall('(39)'),
          ],
        ),
        const SizedBox(height: LmuSizes.size_16),

        // Individual ratings
        _buildRatingItem('Erklärung & Aufbau', 3.2),
        _buildRatingItem('Materialien', 3.8),
        _buildRatingItem('Aufwand', 2.2),
        _buildRatingItem('Lehrperson', 4.1),
        _buildRatingItem('Prüfungsaufbau', 1.2),
        _buildRatingItem('Gesamteindruck', 3.2),

        const SizedBox(height: LmuSizes.size_16),
        LmuText.bodySmall(
          'Anzeigen der Bewertungskriterien',
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ],
    );
  }

  Widget _buildRatingItem(String label, double rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: LmuSizes.size_8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: LmuText.bodySmall(label),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                LmuText.bodySmall(rating.toStringAsFixed(1)),
                const SizedBox(width: LmuSizes.size_4),
                Icon(Icons.star, size: 16, color: Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LectureDetailPageDriverProvider extends WidgetDriverProvider<LectureDetailPageDriver> {
  _LectureDetailPageDriverProvider(this.lectureId, this.lectureTitle);

  final String lectureId;
  final String lectureTitle;

  @override
  LectureDetailPageDriver buildDriver() {
    return LectureDetailPageDriver(
      lectureId: lectureId,
      lectureTitle: lectureTitle,
    );
  }

  @override
  LectureDetailPageDriver buildTestDriver() {
    return LectureDetailPageDriver(
      lectureId: 'test',
      lectureTitle: 'Test Lecture',
    );
  }
}
