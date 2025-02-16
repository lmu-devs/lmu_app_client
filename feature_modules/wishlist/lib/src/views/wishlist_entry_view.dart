import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/wishlist_cubit.dart';
import '../bloc/wishlist_state.dart';
import '../repository/api/api.dart';
import '../services/services.dart';
import '../util/util.dart';
import '../widgets/widgets.dart';

class WishlistEntryView extends StatelessWidget {
  const WishlistEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      bloc: GetIt.I.get<WishlistCubit>(),
      builder: (context, state) {
        if (state is WishlistLoadSuccess) {
          List<WishlistModel> wishlistModels = state.wishlistModels;
          final wishlistUserPreferencesService = GetIt.I<WishlistUserPreferenceService>();

          return ValueListenableBuilder<List<String>>(
            valueListenable: wishlistUserPreferencesService.likedWishlistIdsNotifier,
            builder: (context, likedWishlistIds, child) {
              final publicWishlistModels = wishlistModels
                  .where((model) => model.status != WishlistStatus.hidden && model.status != WishlistStatus.done)
                  .toList()
                ..sort((a, b) {
                  const statusOrder = {
                    WishlistStatus.beta: 0,
                    WishlistStatus.development: 1,
                    WishlistStatus.none: 2,
                  };
                  final statusComparison = statusOrder[a.status]!.compareTo(statusOrder[b.status]!);
                  if (statusComparison != 0) return statusComparison;
                  return b.ratingModel.likeCount.compareTo(a.ratingModel.likeCount);
                });
              return WishlistEntrySection(
                wishlistModels: publicWishlistModels,
                likedWishlistIds: likedWishlistIds,
              );
            },
          );
        }

        return const WishlistEntrySectionLoading(length: 4);
      },
    );
  }
}
