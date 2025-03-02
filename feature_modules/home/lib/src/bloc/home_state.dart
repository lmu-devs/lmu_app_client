import 'package:equatable/equatable.dart';

import '../repository/api/models/home/home_data.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadSuccess extends HomeState {
  HomeLoadSuccess({required this.homeData});

  final HomeData homeData;

  @override
  List<Object?> get props => [homeData];
}

class HomeLoadFailure extends HomeState {
  @override
  List<Object?> get props => [];
}
