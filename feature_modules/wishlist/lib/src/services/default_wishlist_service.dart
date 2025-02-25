import 'package:flutter/widgets.dart';
import 'package:shared_api/wishlist.dart';

import '../routes/wishlist_routes.dart';

class DefaultWishlistService extends WishlistService {
  @override
  void navigateToWishlistPage(BuildContext context) {
    const WishlistMainRoute().go(context);
  }
}
