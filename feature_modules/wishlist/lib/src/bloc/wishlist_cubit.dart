import 'package:core/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../repository/wishlist_repository.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistLoadInProgress());

  final _wishlistRepository = GetIt.I.get<WishlistRepository>();

  Future<void> loadWishlistEntries() async {
    final cachedWishlistEntries = await _wishlistRepository.getCachedWishlistEntries();
    emit(WishlistLoadInProgress(wishlistModels: cachedWishlistEntries));

    try {
      final wishlistModels = await _wishlistRepository.getWishlistEntries();
      emit(WishlistLoadSuccess(wishlistModels: wishlistModels));
    } catch (e) {
      if (cachedWishlistEntries != null) {
        emit(WishlistLoadSuccess(wishlistModels: cachedWishlistEntries));
      } else {
        if (e is NoNetworkException) {
          emit(WishlistLoadFailure(loadState: LoadState.noNetworkError));
        } else {
          emit(WishlistLoadFailure(loadState: LoadState.genericError));
        }
      }
    }
  }
}
