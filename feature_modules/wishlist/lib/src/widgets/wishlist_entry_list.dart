import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/wishlist_cubit.dart';
import '../bloc/wishlist_state.dart';
import 'widgets.dart';

class WishlistEntryList extends StatelessWidget {
  const WishlistEntryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      bloc: GetIt.I.get<WishlistCubit>(),
      builder: (context, state) {
        Widget child = const WishlistEntrySectionLoading(key: ValueKey("wishlistLoading"), length: 5);

        if (state is WishlistLoadInProgress && state.wishlistModels != null) {
          child = WishlistEntrySection(key: const ValueKey("wishlistContent"), wishlistModels: state.wishlistModels!);
        } else if (state is WishlistLoadSuccess) {
          child = WishlistEntrySection(key: const ValueKey("wishlistContent"), wishlistModels: state.wishlistModels);
        }

        return LmuPageAnimationWrapper(
          child: Align(
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
    );
  }
}
