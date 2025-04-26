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

    final libraries = await _repository.getLibraries();

    if (libraries == null && cachedLibraries == null) {
      emit(const LibrariesLoadFailure());
      return;
    }
    emit(LibrariesLoadSuccess(libraries: libraries ?? cachedLibraries!));
  }
}
