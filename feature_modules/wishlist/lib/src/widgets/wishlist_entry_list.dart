import 'package:core/components.dart';
import 'package:core/utils.dart';
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
    final wishlistCubit = GetIt.I.get<WishlistCubit>();
    return BlocBuilder<WishlistCubit, WishlistState>(
      bloc: wishlistCubit,
      builder: (context, state) {
        Widget child = const WishlistEntrySectionLoading(
          key: ValueKey("wishlistLoading"),
          lengths: [2, 4],
        );

        if (state is WishlistLoadInProgress && state.wishlistModels != null) {
          child = WishlistEntrySection(key: const ValueKey("wishlistContent"), wishlistModels: state.wishlistModels!);
        } else if (state is WishlistLoadSuccess) {
          child = WishlistEntrySection(key: const ValueKey("wishlistContent"), wishlistModels: state.wishlistModels);
        } else if (state is WishlistLoadFailure) {
          final isNoNetworkError = state.loadState.isNoNetworkError;
          child = LmuEmptyState(
            key: ValueKey("sports${isNoNetworkError ? 'NoNetwork' : 'GenericError'}"),
            type: isNoNetworkError ? EmptyStateType.noInternet : EmptyStateType.generic,
            hasVerticalPadding: true,
            onRetry: () => wishlistCubit.loadWishlistEntries(),
          );
        }

        return child;
      },
    );
  }
}
