import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

import '../../../application/usecase/favorite_lectures_usecase.dart';
import '../../../application/usecase/get_lectures_usecase.dart';
import '../../../domain/interface/lectures_driver_dependencies.dart';
import '../../../presentation/viewmodel/lecture_list_page_driver.dart';
import '../adapter/lectures_driver_adapters.dart';

/// Factory for creating LectureListPageDriver with proper dependency injection
class LecturesDriverFactory {
  const LecturesDriverFactory({
    required this.lecturesUsecase,
    required this.favoritesUsecase,
    required this.facultiesApi,
  });

  /// Create factory with default dependencies from GetIt
  factory LecturesDriverFactory.fromGetIt() {
    return LecturesDriverFactory(
      lecturesUsecase: GetLecturesUsecaseAdapter(GetIt.I.get<GetLecturesUsecase>()),
      favoritesUsecase: FavoriteLecturesUsecaseAdapter(GetIt.I.get<FavoriteLecturesUsecase>()),
      facultiesApi: FacultiesApiAdapter(GetIt.I.get<FacultiesApi>()),
    );
  }

  /// Create factory with custom dependencies (useful for testing)
  factory LecturesDriverFactory.withDependencies({
    required GetLecturesUsecase lecturesUsecase,
    required FavoriteLecturesUsecase favoritesUsecase,
    required FacultiesApi facultiesApi,
  }) {
    return LecturesDriverFactory(
      lecturesUsecase: GetLecturesUsecaseAdapter(lecturesUsecase),
      favoritesUsecase: FavoriteLecturesUsecaseAdapter(favoritesUsecase),
      facultiesApi: FacultiesApiAdapter(facultiesApi),
    );
  }

  final LecturesUsecaseInterface lecturesUsecase;
  final FavoritesUsecaseInterface favoritesUsecase;
  final FacultiesApiInterface facultiesApi;

  /// Create driver with injected dependencies
  LectureListPageDriver createDriver(int facultyId) {
    return LectureListPageDriver(
      facultyId: facultyId,
      lecturesUsecase: lecturesUsecase,
      favoritesUsecase: favoritesUsecase,
      facultiesApi: facultiesApi,
    );
  }

  /// Dispose all adapters to prevent memory leaks
  void dispose() {
    // Note: Adapters don't need disposal as they delegate to the actual use cases
    // The actual use cases should be disposed by their owners
  }
}
