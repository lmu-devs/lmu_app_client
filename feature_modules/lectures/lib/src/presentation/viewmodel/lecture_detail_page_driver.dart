import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/favorite_lectures_usecase.dart';
import '../../application/usecase/get_lectures_usecase.dart';
import '../../domain/model/lecture.dart';

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

  late LmuLocalizations _localizations;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _favoritesUsecase.addListener(_onStateChanged);

    if (_usecase.data.isEmpty) {
      _usecase.load();
    }
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
  bool get isNotFound => _usecase.loadState == LecturesLoadState.success && lecture == null;

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

  // Localization
  String get loadingText => _localizations.lectures.loading;
  String get lectureNotFoundText => _localizations.lectures.lectureNotFound;
  String get errorText => _localizations.app.somethingWentWrong;
  String get retryText => _localizations.app.tryAgain;

  // State change handling
  void _onStateChanged() {
    notifyWidget();
  }

  // Actions
  void onRetry() {
    _usecase.load();
  }

  void onFavoriteToggle() {
    _favoritesUsecase.toggleFavorite(_lectureId);
  }
}
