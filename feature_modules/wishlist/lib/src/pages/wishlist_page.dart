import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../views/wishlist_success_view.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.wishlist.tabTitle,
      body: const WishlistSuccessView(),
    );
  }
}
