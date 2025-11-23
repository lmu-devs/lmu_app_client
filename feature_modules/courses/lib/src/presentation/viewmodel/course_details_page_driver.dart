import 'package:core/localizations.dart';
import 'package:core_routes/courses.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_courses_usecase.dart';
import '../../application/usecase/get_course_details_usecase.dart';
import '../../application/usecase/get_courses_usecase.dart';
import '../../domain/model/course_details_model.dart';
import '../../domain/model/person_model.dart';
import '../../domain/model/session_model.dart';
import '../../infrastructure/primary/router/person_details_data.dart';

part 'course_details_page_driver.g.dart';

class CourseSessionData {
  CourseSessionData({
    required this.time,
    required this.duration,
    this.room,
  });

  final String time;
  final String duration;
  final String? room;
}

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
  })  : _facultyId = facultyId,
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

  CourseDetailsModel? get courseDetails => _usecase.data;

  bool get isLoading =>
      _usecase.loadState == CoursesLoadState.loading ||
      _usecase.loadState == CoursesLoadState.initial;

  bool get isFavorite => _favoritesUsecase.isFavorite(courseId);

  Future<void> toggleFavorite(int id) async {
    await _favoritesUsecase.toggleFavorite(id);
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

  List<CourseSessionData> get sessions {
    final details = _usecase.data;
    if (details == null || details.sessions.isEmpty) {
      return [];
    }

    return details.sessions.map((session) {
      return CourseSessionData(
        time: _formatTime(session),
        duration: _formatDuration(session),
        room: session.room,
      );
    }).toList();
  }

  String _formatTime(SessionModel session) {
    final List<String> parts = [];

    parts.add(_mapRhythm(session.rhythm));

    if (session.weekday != null) {
      parts.add(_mapWeekday(session.weekday!));
    }

    final start = _cleanTime(session.startingTime);
    final end = _cleanTime(session.endingTime);

    if (start.isNotEmpty && end.isNotEmpty) {
      parts.add("$start-$end");
    }

    return parts.join(", ");
  }

  String _formatDuration(SessionModel session) {
    final start = _formatDate(session.durationStart);
    final end = _formatDate(session.durationEnd);

    if (start.isEmpty && end.isEmpty) return "-";
    if (start.isNotEmpty && end.isEmpty) return start;
    return "$start - $end";
  }

  String _cleanTime(String? time) {
    if (time == null) return "";
    final parts = time.split(':');
    if (parts.length >= 2) {
      return "${parts[0]}:${parts[1]}";
    }
    return time;
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        return "${parts[2]}.${parts[1]}.${parts[0]}";
      }
      return dateStr;
    } catch (e) {
      return dateStr;
    }
  }

  String _mapWeekday(String day) {
    switch (day.toUpperCase()) {
      case 'MONDAY':
        return 'Mo';
      case 'TUESDAY':
        return 'Di';
      case 'WEDNESDAY':
        return 'Mi';
      case 'THURSDAY':
        return 'Do';
      case 'FRIDAY':
        return 'Fr';
      case 'SATURDAY':
        return 'Sa';
      case 'SUNDAY':
        return 'So';
      default:
        return day;
    }
  }

  String _mapRhythm(String rhythm) {
    final r = rhythm.toLowerCase();
    if (r.contains('woch')) return 'wöchtl.';
    if (r.contains('einzel')) return 'Einzelterm.';
    return rhythm;
  }

  String get courseTime => _localizations.courses.courseTime;

  String get courseDuration => _localizations.courses.courseDuration;

  String get courseRoom => _localizations.courses.courseRoom;

  String get persons => _localizations.courses.persons;

  String get content => _localizations.courses.content;

  void onPersonsDetailsPressed(
      BuildContext context, List<PersonModel> persons) {
    CourseDetailsPersonsRoute(
      facultyId: _facultyId,
      courseId: _courseId,
      name: name,
      language: language,
      degree: degree,
      sws: sws,
      $extra: PersonDetailsData(persons: persons),
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
