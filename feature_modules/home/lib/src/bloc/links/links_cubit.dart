import 'package:core/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/home_repository.dart';
import 'links_state.dart';

class LinksCubit extends Cubit<LinksState> {
  LinksCubit() : super(const LinksInitial());

  final _repository = GetIt.I.get<HomeRepository>();

  Future<void> getLinks() async {
    final cachedData = await _repository.getCachedLinks();
    emit(LinksLoadInProgress(links: cachedData));

    try {
      final links = await _repository.getLinks();
      emit(LinksLoadSuccess(links: links));
    } catch (e) {
      if (cachedData != null) {
        emit(LinksLoadSuccess(links: cachedData));
      } else {
        if (e is NoNetworkException) {
          emit(const LinksLoadFailure(loadState: LoadState.noNetworkError));
        } else {
          emit(const LinksLoadFailure(loadState: LoadState.genericError));
        }
      }
    }
  }
}
