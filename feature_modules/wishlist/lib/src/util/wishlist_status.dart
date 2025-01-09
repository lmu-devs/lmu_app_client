import 'package:core/localizations.dart';
import 'package:flutter/cupertino.dart';

enum WishlistStatus {
  none,
  hidden,
  development,
  beta,
  done,
}

extension WishlistStatusExtension on WishlistStatus {
  String getValue(BuildContext context) {
    switch (this) {
      case WishlistStatus.none:
        return '';
      case WishlistStatus.hidden:
        return context.locals.wishlist.wishlistStatusHidden;
      case WishlistStatus.development:
        return context.locals.wishlist.wishlistStatusDevelopment;
      case WishlistStatus.beta:
        return context.locals.wishlist.wishlistStatusBeta;
      case WishlistStatus.done:
        return context.locals.wishlist.wishlistStatusDone;
    }
  }
}

extension WishlistStatusMapper on WishlistStatus {
  static WishlistStatus fromString(String status) {
    switch (status) {
      case "NONE":
        return WishlistStatus.none;
      case "HIDDEN":
        return WishlistStatus.hidden;
      case "DEVELOPMENT":
        return WishlistStatus.development;
      case "BETA":
        return WishlistStatus.beta;
      case "DONE":
        return WishlistStatus.done;
      default:
        throw ArgumentError("Invalid status: $status");
    }
  }
}
