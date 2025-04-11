import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/home_repository.dart';
import 'benefits_state.dart';

class BenefitsCubit extends Cubit<BenefitsState> {
  BenefitsCubit() : super(const BenefitsInitial());

  final _repository = GetIt.I.get<HomeRepository>();

  Future<void> getBenefits() async {
    final cachedData = await _repository.getCachedBenefits();
    emit(BenefitsLoadInProgress(benefits: cachedData));

    final benefits = await _repository.getBenefits();

    if (benefits == null && cachedData == null) {
      emit(const BenefitsLoadFailure());
      return;
    }

    emit(BenefitsLoadSuccess(benefits: benefits ?? cachedData!));
  }
}
