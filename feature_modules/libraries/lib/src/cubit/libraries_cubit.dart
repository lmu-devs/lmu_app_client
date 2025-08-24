import 'package:core/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../repository/libraries_repository.dart';
import 'libraries_state.dart';

class LibrariesCubit extends Cubit<LibrariesState> {
  LibrariesCubit() : super(const LibrariesInitial());

  final _repository = GetIt.I.get<LibrariesRepository>();

  Future<void> loadLibraries() async {
    final cachedLibraries = await _repository.getCachedLibraries();
    emit(LibrariesLoadInProgress(libraries: cachedLibraries));

    try {
      final retrievedLibraries = await _repository.getLibraries();
      emit(LibrariesLoadSuccess(libraries: retrievedLibraries));
    } catch (e) {
      if (cachedLibraries != null) {
        emit(LibrariesLoadSuccess(libraries: cachedLibraries));
      } else {
        if (e is NoNetworkException) {
          emit(const LibrariesLoadFailure(loadState: LoadState.noNetworkError));
        } else {
          emit(const LibrariesLoadFailure(loadState: LoadState.genericError));
        }
      }
    }
  }
}
