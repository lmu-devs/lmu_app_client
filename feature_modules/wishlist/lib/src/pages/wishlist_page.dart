import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/wishlist_cubit.dart';
import '../bloc/wishlist_state.dart';
import '../views/wishlist_success_view.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffoldWithAppBar(
      largeTitle: context.locals.wishlist.tabTitle,
      body: BlocBuilder<WishlistCubit, WishlistState>(
        bloc: GetIt.I.get<WishlistCubit>(),
        builder: (context, state) {
          if (state is WishlistLoadSuccess) {
            return WishlistSuccessView(wishlistModels: state.wishlistModels);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
