import 'package:equatable/equatable.dart';

import '../../repository/api/models/taste_profile/taste_profile_model.dart';

abstract class TasteProfileState extends Equatable {}

class TasteProfileInitial extends TasteProfileState {
  @override
  List<Object> get props => [];
}

class TasteProfileLoadInProgress extends TasteProfileState {
  @override
  List<Object> get props => [];
}

class TasteProfileLoadSuccess extends TasteProfileState {
  TasteProfileLoadSuccess(this.tasteProfile);
  final TasteProfileModel tasteProfile;

  @override
  List<Object> get props => [tasteProfile];
}

class TasteProfileLoadFailure extends TasteProfileState {
  @override
  List<Object> get props => [];
}
