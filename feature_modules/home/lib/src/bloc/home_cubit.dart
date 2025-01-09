import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository}) : super(HomeInitial());

  final HomeRepository homeRepository;

  Future<void> loadHomeData() async {
    try {
      emit(HomeLoading());
      final homeData = await homeRepository.getHomeData();
      emit(HomeLoadSuccess(homeData: homeData));
    } catch (e) {
      emit(HomeLoadFailure());
    }
  }
}