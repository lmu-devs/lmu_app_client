import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../../domain/model/lecture.dart';

abstract class LectureListState extends Equatable {
  const LectureListState();
}

class LectureListInitial extends LectureListState {
  @override
  List<Object?> get props => [];
}

class LectureListLoadInProgress extends LectureListState {
  const LectureListLoadInProgress({this.lectures});

  final List<Lecture>? lectures;

  @override
  List<Object?> get props => [lectures];
}

class LectureListLoadSuccess extends LectureListState {
  const LectureListLoadSuccess({
    required this.lectures,
    required this.isFacultyFavorite,
    required this.showOnlyFavorites,
    required this.selectedSemester,
  });

  final List<Lecture> lectures;
  final bool isFacultyFavorite;
  final bool showOnlyFavorites;
  final String selectedSemester;

  @override
  List<Object?> get props => [lectures, isFacultyFavorite, showOnlyFavorites, selectedSemester];
}

class LectureListLoadFailure extends LectureListState {
  const LectureListLoadFailure({this.loadState = LoadState.genericError});

  final LoadState loadState;

  @override
  List<Object?> get props => [loadState];
}
