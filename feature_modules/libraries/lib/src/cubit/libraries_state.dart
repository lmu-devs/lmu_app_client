import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../repository/api/api.dart';

abstract class LibrariesState extends Equatable {
  const LibrariesState();

  @override
  List<Object> get props => [];
}

class LibrariesInitial extends LibrariesState {
  const LibrariesInitial();
}

class LibrariesLoadInProgress extends LibrariesState {
  const LibrariesLoadInProgress({this.libraries});

  final List<LibraryModel>? libraries;
}

class LibrariesLoadSuccess extends LibrariesState {
  const LibrariesLoadSuccess({
    required this.libraries,
  });

  final List<LibraryModel> libraries;

  @override
  List<Object> get props => [libraries];
}

class LibrariesLoadFailure extends LibrariesState {
  const LibrariesLoadFailure({this.loadState = LoadState.genericError});

  final LoadState loadState;

  @override
  List<Object> get props => [loadState];
}
