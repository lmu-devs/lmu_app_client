import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/home_repository.dart';
import 'benefits_state.dart';

class BenefitsCubit extends Cubit<BenefitsState> {
  BenefitsCubit() : super(const BenefitsInitial());

  final _repository = GetIt.I.get<HomeRepository>();

  Future<void> getBenefits() async {
    emit(const BenefitsLoadInProgress());

    try {
      final benefits = await _repository.getBenefits();
      emit(BenefitsLoadSuccess(benefits: benefits));
    } catch (e) {
      emit(const BenefitsLoadFailure());
    }
  }
}
