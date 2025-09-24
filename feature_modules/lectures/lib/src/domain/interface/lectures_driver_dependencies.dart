import 'package:flutter/foundation.dart';

import '../model/lecture.dart';
import '../service/semester_config_service.dart';

/// Interface for lectures use case to decouple driver from implementation
abstract class LecturesUsecaseInterface {
  // State getters
  List<Lecture> get lectures;
  bool get isLoading;
  bool get hasError;
  String? get errorMessage;
  String? get errorDetails;
  bool get isRetryable;
  bool get showOnlyFavorites;

  // Actions
  Future<void> load();
  Future<void> reload();
  void toggleShowOnlyFavorites();

  // Semester management
  List<SemesterInfo> get availableSemesters;
  SemesterInfo get selectedSemester;
  void changeSemester(SemesterInfo semester);

  // State management
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
  void dispose();
}

/// Interface for favorites use case to decouple driver from implementation
abstract class FavoritesUsecaseInterface {
  // State getters
  Set<String> get favoriteIds;
  bool isFavorite(String lectureId);

  // Actions
  void toggleFavorite(String lectureId);
  void addFavorite(String lectureId);
  void removeFavorite(String lectureId);

  // State management
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
  void dispose();
}

/// Interface for faculties API to decouple driver from implementation
abstract class FacultiesApiInterface {
  List<Faculty> get allFaculties;
  Faculty? getFacultyById(int id);
}

/// Faculty model for the interface
class Faculty {
  const Faculty(this.id, this.name);

  final int id;
  final String name;
}
