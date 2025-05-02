import 'package:core_routes/wishlist.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_api/wishlist.dart';

class DefaultWishlistService extends WishlistService {
  @override
  void navigateToWishlistPage(BuildContext context) {
    const WishlistMainRoute().go(context);
  }
}
