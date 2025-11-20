import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/courses.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_courses_usecase.dart';
import '../../application/usecase/recent_searches_usecase.dart';
import '../../domain/model/course_model.dart';

part 'courses_search_driver.g.dart';

class CourseSearchEntry extends SearchEntry {
  const CourseSearchEntry({
    required super.title,
    required this.course,
  });

  final CourseModel course;
}

@GenerateTestDriver()
class CoursesSearchDriver extends WidgetDriver implements _$DriverProvidedProperties {
  CoursesSearchDriver({
    @driverProvidableProperty required int facultyId,
  }) : _facultyId = facultyId;

  late int _facultyId;
  int get facultyId => _facultyId;

  final _usecase = GetIt.I.get<GetCoursesUsecase>();
  final _recentSearchController = LmuRecentSearchController<CourseSearchEntry>();
  final _recentSearchesUsecase = GetIt.I.get<RecentSearchesUsecase>();

  late LmuLocalizations _localizations;

  List<CourseModel> get recentSearches => _recentSearchesUsecase.recentSearches;

  @TestDriverDefaultValue(_TestLmuRecentSearchController())
  LmuRecentSearchController<CourseSearchEntry> get recentSearchController => _recentSearchController;



  List<CourseModel> get courses => _usecase.data;

  List<CourseModel> get facultyCourses => courses.where((course) => course.publishId == facultyId).toList();

  String get pageTitle => _localizations.app.search;

  List<CourseSearchEntry> get searchEntries => courses
      .map((course) => CourseSearchEntry(
            title: course.name,
            course: course,
          ))
      .toList();

  List<CourseSearchEntry> get recentSearchEntries => recentSearches
      .map((course) => CourseSearchEntry(
            title: course.name,
            course: course,
          ))
      .toList();



  void onPersonPressed(BuildContext context, CourseModel course) {
    addRecentSearch(course);
    CourseDetailsRoute(facultyId: facultyId, courseId: course.publishId, courseName: course.name).push(context);
  }

  void updateRecentSearch(List<CourseSearchEntry> recentSearchEntries) {
    if (recentSearchEntries.isEmpty) {
      _recentSearchesUsecase.clearRecentSearches();
    } else {
      for (final entry in recentSearchEntries) {
        _recentSearchesUsecase.addRecentSearch(entry.course);
      }
    }
  }

  Future<void> addRecentSearch(CourseModel course) async {
    await _recentSearchesUsecase.addRecentSearch(course);
  }

  void _updateRecentSearchEntries(CourseSearchEntry input) {
    addRecentSearch(input.course);
  }

  @TestDriverDefaultValue(SizedBox.shrink())
  Widget buildSearchEntry(BuildContext context, CourseSearchEntry entry) {
    final course = entry.course;
    return LmuListItem.action(
      title: course.name,
      subtitle: course.type,
      actionType: LmuListItemAction.chevron,
      onTap: () {
        onPersonPressed(context, course);
        recentSearchController.trigger(entry);
      },
    );
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
    _recentSearchesUsecase.addListener(_onRecentSearchesChanged);
    _recentSearchController.triggerAction = _updateRecentSearchEntries;
  }

  void _onRecentSearchesChanged() {
    notifyWidget();
  }

  @override
  void didUpdateProvidedProperties({
    required int newFacultyId,
  }) {
    _facultyId = newFacultyId;
  }
}

class _TestLmuRecentSearchController extends EmptyDefault implements LmuRecentSearchController<CourseSearchEntry> {
  const _TestLmuRecentSearchController();
}
