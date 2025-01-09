import 'package:equatable/equatable.dart';
import 'package:home/src/repository/api/models/home_model.dart';

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

  final HomeModel homeData;

  @override
  List<Object?> get props => [homeData];
}

class HomeLoadFailure extends HomeState {
  @override
  List<Object?> get props => [];
}
