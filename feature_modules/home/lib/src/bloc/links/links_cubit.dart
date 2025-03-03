import 'dart:io';

import 'package:core/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/home_repository.dart';
import 'links_state.dart';

class LinksCubit extends Cubit<LinksState> {
  LinksCubit() : super(const LinksInitial());

  final _repository = GetIt.I.get<HomeRepository>();

  Future<void> getLinks() async {
    emit(const LinksLoadInProgress());

    try {
      final links = await _repository.getLinks();
      emit(LinksLoadSuccess(links: links));
    } catch (e) {
      if (e is SocketException) {
        listenForConnectivityRestoration(getLinks);
      }
      emit(const LinksLoadFailure());
    }
  }
}
