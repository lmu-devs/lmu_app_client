import 'package:core/localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_lectures_usecase.dart';
import '../../application/usecase/get_lectures_usecase.dart';
import '../../domain/model/lecture.dart';
import '../../infrastructure/secondary/data/api/lectures_api_client.dart';

part 'lecture_detail_page_driver.g.dart';

@GenerateTestDriver()
class LectureDetailPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  LectureDetailPageDriver({
    @driverProvidableProperty required String lectureId,
    @driverProvidableProperty required String lectureTitle,
  })  : _lectureId = lectureId,
        _lectureTitle = lectureTitle;

  late String _lectureId;
  late String _lectureTitle;
  String get lectureId => _lectureId;
  String get lectureTitle => _lectureTitle;

  final _usecase = GetIt.I.get<GetLecturesUsecase>();
  final _favoritesUsecase = GetIt.I.get<FavoriteLecturesUsecase>();
  final _apiClient = GetIt.I.get<LecturesApiClient>();

  LmuLocalizations? _localizations;
  Map<String, dynamic>? _courseDetails;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);

    if (_usecase.data.isEmpty) {
      _usecase.load();
    }

    _loadCourseDetails();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  void didUpdateProvidedProperties({
    required String newLectureId,
    required String newLectureTitle,
  }) {
    _lectureId = newLectureId;
    _lectureTitle = newLectureTitle;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    _favoritesUsecase.removeListener(_onStateChanged);
    super.dispose();
  }

  // State management
  bool get isLoading => _usecase.loadState == LecturesLoadState.loading;
  bool get hasError => _usecase.loadState == LecturesLoadState.error;
  bool get isNotFound => !isLoading && !hasError && lecture == null;

  // Data
  Lecture? get lecture {
    try {
      return _usecase.data.firstWhere((lecture) => lecture.id == _lectureId);
    } catch (e) {
      return null;
    }
  }

  // Display data
  String get displayLectureTitle => lecture?.title ?? _lectureTitle;
  bool get isFavorite => _favoritesUsecase.isFavorite(_lectureId);

  // Course details from API
  bool get hasCourseDetails => _courseDetails != null;
  String get courseLanguage => _courseDetails?['language'] ?? 'English';
  int get maxParticipants => _courseDetails?['maxParticipants'] ?? 80;
  String get registrationDeadline => _courseDetails?['registrationDeadline'] ?? '15.10.2024';
  String get examRegistrationDeadline => _courseDetails?['examRegistrationDeadline'] ?? '30.11.2024';
  String get examDate => _courseDetails?['examDate'] ?? '15.02.2025';

  // Schedule data
  Map<String, dynamic>? get schedule => _courseDetails?['schedule'];
  String get scheduleTime => schedule?['time'] ?? 'wöchtl., Mo, 16:15-17:45';
  String get scheduleDuration => schedule?['duration'] ?? '12.05.2025 - 23.07.2025';
  String get scheduleAddress => schedule?['address'] ?? 'Luisenstr. 37 (C)';
  String get scheduleRoom => schedule?['room'] ?? 'C 006';

  // Ratings data
  Map<String, dynamic>? get ratings => _courseDetails?['ratings'];
  double get overallRating => ratings?['overall']?.toDouble() ?? 3.8;
  int get totalRatings => ratings?['totalRatings'] ?? 39;
  Map<String, dynamic>? get ratingCategories => ratings?['categories'];

  // Localization
  String get loadingText => _localizations?.lectures.loading ?? 'Loading...';
  String get lectureNotFoundText => _localizations?.lectures.lectureNotFound ?? 'Lecture not found';
  String get errorText => _localizations?.app.somethingWentWrong ?? 'Something went wrong';
  String get retryText => _localizations?.app.tryAgain ?? 'Try again';

  // State change handling
  void _onStateChanged() {
    notifyWidget();
  }

  Future<void> _loadCourseDetails() async {
    try {
      final courseId = _getCourseIdFromTitle(_lectureTitle);
      _courseDetails = await _apiClient.getCourseDetails(courseId);
      notifyWidget();
    } catch (e) {
      // Handle error - for now just log
      debugPrint('Error loading course details: $e');
    }
  }

  String _getCourseIdFromTitle(String title) {
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('data structures')) {
      return 'data_structures_1'; // Default faculty ID
    } else if (lowerTitle.contains('software engineering')) {
      return 'software_engineering_1';
    } else if (lowerTitle.contains('database')) {
      return 'database_systems_1';
    } else if (lowerTitle.contains('computer networks')) {
      return 'computer_networks_1';
    } else if (lowerTitle.contains('machine learning')) {
      return 'machine_learning_1';
    }
    return 'natural_computing_1'; // Default for other courses
  }

  // Actions
  void onRetry() {
    _usecase.load();
  }

  void onFavoriteToggle() {
    _favoritesUsecase.toggleFavorite(_lectureId);
  }
}
