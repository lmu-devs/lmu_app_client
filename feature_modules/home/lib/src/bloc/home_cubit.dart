import 'dart:async';

import 'package:core/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository}) : super(HomeInitial());

  final HomeRepository homeRepository;

  Future<void> loadHomeData() async {
    final cachedData = await homeRepository.getCachedHomeData();
    emit(HomeLoadInProgress(homeData: cachedData));

    final homeData = await homeRepository.getHomeData();

    if (homeData == null && cachedData == null) {
      emit(HomeLoadFailure());
      listenForConnectivityRestoration(loadHomeData);
      return;
    }
    emit(HomeLoadSuccess(homeData: homeData ?? cachedData!));
  }
}
