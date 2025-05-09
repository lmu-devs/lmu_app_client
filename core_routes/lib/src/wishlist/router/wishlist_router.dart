import 'package:flutter/material.dart';

import '../models/router_wishlist_model.dart';

abstract class WishlistRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, RWishlistModel wishlistModel);
}
