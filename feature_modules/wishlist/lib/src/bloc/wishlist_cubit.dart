import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/wishlist_repository.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    required this.wishlistRepository,
  }) : super(WishlistInitial());

  final WishlistRepository wishlistRepository;

  void loadWishlistEntries() async {
    emit(WishlistLoadInProgress());

    try {
      final wishlistEntries = await wishlistRepository.getWishlistEntries();

      emit(WishlistLoadSuccess(wishlistModels: wishlistEntries));
    } catch (e) {
      emit(WishlistLoadInProgress());
    }
  }
}
