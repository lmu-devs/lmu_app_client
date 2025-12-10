import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/courses.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_courses_usecase.dart';
import '../../application/usecase/get_course_details_usecase.dart';
import '../../application/usecase/get_courses_usecase.dart';
import '../../domain/model/course_details_model.dart';
import '../../domain/model/person_model.dart';
import '../../domain/model/session_model.dart';

part 'course_details_page_driver.g.dart';

@GenerateTestDriver()
class CourseDetailsPageDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  CourseDetailsPageDriver({
    @driverProvidableProperty required int facultyId,
    @driverProvidableProperty required int courseId,
    @driverProvidableProperty required this.name,
    @driverProvidableProperty required this.language,
    @driverProvidableProperty this.degree,
    @driverProvidableProperty this.sws,
  })
      : _facultyId = facultyId,
        _courseId = courseId;

  late final int _facultyId;
  late int _courseId;

  final String name;
  final String language;
  final String? degree;
  final int? sws;

  int get facultyId => _facultyId;

  int get courseId => _courseId;

  final _usecase = GetIt.I.get<GetCourseDetailsUsecase>();
  final _favoritesUsecase = GetIt.I.get<FavoriteCoursesUsecase>();

  late LmuLocalizations _localizations;

  String get pageTitle => name;

  String get shareButtonText => _localizations.app.share;

  String get sessionsText => _localizations.courses.sessions;

  String get personText => _localizations.courses.person;

  String get personsText => _localizations.courses.persons;

  String get contentText => _localizations.courses.content;

  String get shareUrl {
    final route = CourseDetailsRoute(
      facultyId: _facultyId,
      courseId: _courseId,
      name: name,
      language: language,
      degree: degree,
      sws: sws,
    );

    final String host = LmuDevStrings.lmuDevWebsite.substring(
        0, LmuDevStrings.lmuDevWebsite.length - 1);
    return '$host${route.location}';
  }

  String lastUpdatedText() {
    final raw = courseDetails!.lastUpdated.trim();
    final date = DateTime.parse(raw);

    final formatted = DateFormat('dd.MM.yyyy, HH:mm').format(date);

    return '${_localizations.courses.lastUpdated}$formatted';
  }

  CourseDetailsModel? get courseDetails => _usecase.data;

  bool get isLoading =>
      _usecase.loadState == CoursesLoadState.loading ||
          _usecase.loadState == CoursesLoadState.initial;

  bool get isFavorite => _favoritesUsecase.isFavorite(courseId);

  Future<void> toggleFavorite(int id) async {
    await _favoritesUsecase.toggleFavorite(facultyId, id);
  }

  String get quickfactText {
    final List<String> parts = [];

    if (degree != null && degree != "-") {
      parts.add(degree!);
    }

    if (sws != null) {
      parts.add("$sws SWS");
    }

    parts.add(language);

    return parts.join(" • ");
  }

  void onSessionsDetailsPressed(BuildContext context,
      List<SessionModel> sessions) {
    CourseDetailsSessionsRoute(
      facultyId: _facultyId,
      courseId: _courseId,
      name: name,
      language: language,
      degree: degree,
      sws: sws,
      $extra: sessions,
    ).push(context);
  }

  void onPersonsDetailsPressed(BuildContext context,
      List<PersonModel> persons) {
    CourseDetailsPersonsRoute(
      facultyId: _facultyId,
      courseId: _courseId,
      name: name,
      language: language,
      degree: degree,
      sws: sws,
      $extra: persons,
    ).push(context);
  }

  void onContentDetailsPressed(BuildContext context, String content) {
    CourseDetailsContentRoute(
      facultyId: _facultyId,
      courseId: _courseId,
      name: name,
      language: language,
      content: content,
      degree: degree,
      sws: sws,
    ).push(context);
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);
    _usecase.load(courseId);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  void didUpdateProvidedProperties({
    required int newFacultyId,
    required int newCourseId,
    required String newName,
    required String newLanguage,
    String? newDegree,
    int? newSws,
  }) {
    if (_courseId != newCourseId) {
      _courseId = newCourseId;
      _usecase.load(_courseId);
    }
  }

  void _onStateChanged() {
    notifyWidget();
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    _favoritesUsecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
