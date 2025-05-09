import 'package:core_routes/wishlist.dart';
import 'package:flutter/widgets.dart';

import '../pages/pages.dart';
import '../repository/api/models/wishlist_model.dart';

class WishlistRouterImpl extends WishlistRouter {
  @override
  Widget buildMain(BuildContext context) => const WishlistPage();

  @override
  Widget buildDetails(BuildContext context, RWishlistModel wishlistModel) => WishlistDetailsPage(
        wishlistModel: wishlistModel as WishlistModel,
      );
}
