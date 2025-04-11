import 'package:core/extensions.dart';
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

    final wishlistEntries = await _wishlistRepository.getWishlistEntries();
    if (wishlistEntries == null && cachedWishlistEntries == null) {
      emit(WishlistLoadFailure());
      listenForConnectivityRestoration(loadWishlistEntries);
      return;
    }

    emit(WishlistLoadSuccess(wishlistModels: wishlistEntries ?? cachedWishlistEntries!));
  }
}
