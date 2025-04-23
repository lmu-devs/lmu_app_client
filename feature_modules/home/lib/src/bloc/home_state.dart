import 'package:equatable/equatable.dart';

import '../repository/api/models/home/home_featured.dart';
import '../repository/api/models/home/home_tile.dart';

abstract class HomeState extends Equatable {}

class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadInProgress extends HomeState {
  HomeLoadInProgress({this.featured, this.tiles});

  final HomeFeatured? featured;
  final List<HomeTile>? tiles;

  @override
  List<Object?> get props => [featured, tiles];
}

class HomeLoadSuccess extends HomeState {
  HomeLoadSuccess({required this.tiles, this.featured});

  final HomeFeatured? featured;
  final List<HomeTile> tiles;

  @override
  List<Object?> get props => [featured, tiles];
}

class HomeLoadFailure extends HomeState {
  @override
  List<Object?> get props => [];
}
