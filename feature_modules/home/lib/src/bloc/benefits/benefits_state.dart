import 'package:equatable/equatable.dart';

import '../../repository/api/models/benefits/benefit_model.dart';

abstract class BenefitsState extends Equatable {
  const BenefitsState();

  @override
  List<Object> get props => [];
}

class BenefitsInitial extends BenefitsState {
  const BenefitsInitial();
}

class BenefitsLoadInProgress extends BenefitsState {
  const BenefitsLoadInProgress({this.benefits});

  final List<BenefitModel>? benefits;

  @override
  List<Object> get props => [benefits ?? []];
}

class BenefitsLoadSuccess extends BenefitsState {
  const BenefitsLoadSuccess({
    required this.benefits,
  });

  final List<BenefitModel> benefits;

  @override
  List<Object> get props => [benefits];
}

class BenefitsLoadFailure extends BenefitsState {
  const BenefitsLoadFailure();
}
