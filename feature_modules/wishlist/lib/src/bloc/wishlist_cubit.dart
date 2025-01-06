import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../repository/wishlist_repository.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistLoadInProgress());

  final _wishlistRepository = GetIt.I.get<WishlistRepository>();

  Future<void> loadWishlistEntries() async {
    emit(WishlistLoadInProgress());

    try {
      final wishlistEntries = await _wishlistRepository.getWishlistEntries();

      emit(WishlistLoadSuccess(wishlistModels: wishlistEntries));
    } catch (e) {
      emit(WishlistLoadInProgress());
    }
  }
}
