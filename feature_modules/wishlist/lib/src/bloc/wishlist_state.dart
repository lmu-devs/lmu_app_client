import 'package:core/utils.dart';
import 'package:equatable/equatable.dart';

import '../repository/api/api.dart';

abstract class WishlistState extends Equatable {}

class WishlistInitial extends WishlistState {
  @override
  List<Object?> get props => [];
}

class WishlistLoadInProgress extends WishlistState {
  WishlistLoadInProgress({this.wishlistModels});

  final List<WishlistModel>? wishlistModels;

  @override
  List<Object?> get props => [wishlistModels];
}

class WishlistLoadSuccess extends WishlistState {
  WishlistLoadSuccess({
    required this.wishlistModels,
  });

  final List<WishlistModel> wishlistModels;

  @override
  List<Object?> get props => [wishlistModels];
}

class WishlistLoadFailure extends WishlistState {
  WishlistLoadFailure({required this.loadState});

  final LoadState loadState;
  @override
  List<Object?> get props => [loadState];
}
