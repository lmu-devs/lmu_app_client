import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../bloc/lecture_list_cubit/lecture_list_cubit.dart';
import '../../bloc/lecture_list_cubit/lecture_list_state.dart';
import '../../domain/model/lecture.dart';

class LectureListPageDriver extends WidgetDriver {
  LectureListPageDriver({
    required this.facultyId,
    required this.facultyName,
    required this.cubit,
  }) {
    if (kDebugMode) {
      debugPrint('LectureListPageDriver constructor: facultyId = "$facultyId"');
      debugPrint('LectureListPageDriver constructor: facultyName = "$facultyName"');
    }
  }

  final String facultyId;
  final String facultyName;
  final LectureListCubit cubit;

  late LmuLocalizations _localizations;
  late LmuToast _toast;

  // Getters for UI
  String get displayFacultyName {
    final result = facultyName.isNotEmpty ? facultyName : 'Lectures';
    if (kDebugMode) {
      debugPrint('LectureListPageDriver.displayFacultyName: facultyName = "$facultyName", result = "$result"');
    }
    return result;
  }

  bool get isFacultyFavorite => cubit.isFacultyFavorite;
  bool get showOnlyFavorites => cubit.showOnlyFavorites;
  String get selectedSemester => cubit.selectedSemester;
  int get lectureCount => cubit.lectureCount;
  bool get isLoading => cubit.state is LectureListLoadInProgress;
  bool get hasError => cubit.state is LectureListLoadFailure;

  // Data methods
  List<Lecture> get lectures => cubit.lectures;
  List<Lecture> get filteredLectures => cubit.filteredLectures;
  List<Lecture> get groupedLectures => cubit.groupedLectures;

  // Actions
  void onFacultyFavoriteToggle() {
    try {
      cubit.toggleFacultyFavorite();
      _showToast(cubit.isFacultyFavorite ? 'Faculty added to favorites' : 'Faculty removed from favorites');
    } catch (e) {
      _showErrorToast('Failed to update faculty favorite status');
    }
  }

  void onFavoritesFilterToggle() {
    try {
      cubit.toggleFavoritesFilter();
      _showToast(cubit.showOnlyFavorites ? 'Showing only favorites' : 'Showing all courses');
    } catch (e) {
      _showErrorToast('Failed to update favorites filter');
    }
  }

  void onSemesterChanged(String semester) {
    try {
      cubit.setSemester(semester);
      _showToast('Semester changed to $semester');
    } catch (e) {
      _showErrorToast('Failed to change semester');
    }
  }

  void onLectureCardPressed(BuildContext context, String lectureId, String lectureTitle) {
    try {
      context.push('/studies/lectures/lecture-detail', extra: {
        'lectureId': lectureId,
        'lectureTitle': lectureTitle,
      });
    } catch (e) {
      _showErrorToast('Failed to open lecture details');
    }
  }

  void onLectureFavoriteToggle(String lectureId, bool isFavorite) {
    try {
      cubit.toggleLectureFavorite(lectureId);
      _showToast(isFavorite ? 'Removed from favorites' : 'Added to favorites');
    } catch (e) {
      _showErrorToast('Failed to update favorite status');
    }
  }

  void onSearchPressed() {
    try {
      _showToast('Search functionality coming soon');
    } catch (e) {
      _showErrorToast('Search functionality temporarily unavailable');
    }
  }

  void onSortPressed() {
    try {
      _showToast('Sort functionality coming soon');
    } catch (e) {
      _showErrorToast('Sort functionality temporarily unavailable');
    }
  }

  void onMyStudyPressed() {
    try {
      _showToast('My Study functionality coming soon');
    } catch (e) {
      _showErrorToast('My Study functionality temporarily unavailable');
    }
  }

  void retry() {
    try {
      cubit.loadLectures();
    } catch (e) {
      _showErrorToast('Failed to retry loading');
    }
  }

  void _showToast(String message) {
    try {
      _toast.showToast(
        message: message,
        type: ToastType.success,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      // Fallback to console log if toast fails
      if (kDebugMode) {
        debugPrint('Toast failed: $message');
      }
    }
  }

  void _showErrorToast(String message) {
    try {
      _toast.showToast(
        message: message,
        type: ToastType.error,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      // Fallback to console log if toast fails
      if (kDebugMode) {
        debugPrint('Error toast failed: $message');
      }
    }
  }

  void _onStateChanged() {
    notifyWidget();

    if (cubit.state is LectureListLoadFailure) {
      _showErrorToast(_localizations.app.somethingWentWrong);
    }
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    cubit.stream.listen((_) => _onStateChanged());
    cubit.loadLectures();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
