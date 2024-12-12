import 'package:equatable/equatable.dart';
import '../repository/api/api.dart';

abstract class WishlistState extends Equatable {}

class WishlistInitial extends WishlistState {
  @override
  List<Object?> get props => [];
}

class WishlistLoadInProgress extends WishlistState {
  @override
  List<Object?> get props => [];
}

class WishlistLoadSuccess extends WishlistState {
  WishlistLoadSuccess({
    required this.wishlistModels,
  });

  final List<WishlistModel> wishlistModels;

  @override
  List<Object?> get props => [wishlistModels];
}
