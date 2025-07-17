import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/api/models/home/home_featured.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository}) : super(HomeInitial());

  final HomeRepository homeRepository;

  Future<void> loadHomeData() async {
    final cachedData = await homeRepository.getCachedHomeData();
    final closedFeaturedTiles = await homeRepository.getClosedFeaturedTiles();
    final cachedTiles = cachedData?.tiles;
    final cachedFeatured = cachedData?.featured;
    final featured = _selectFeaturedTile(cachedFeatured, closedFeaturedTiles);

    emit(HomeLoadInProgress(tiles: cachedTiles, featured: featured));

    final homeData = await homeRepository.getHomeData();

    if (homeData == null && cachedData == null) {
      emit(HomeLoadFailure());
      return;
    }

    final newFeatured = _selectFeaturedTile(homeData?.featured, closedFeaturedTiles);
    final tiles = homeData?.tiles ?? cachedTiles;
    emit(HomeLoadSuccess(tiles: tiles ?? [], featured: newFeatured));
  }

  HomeFeatured? _selectFeaturedTile(
    List<HomeFeatured>? tiles,
    List<String> dismissedIds,
  ) {
    if (tiles == null || tiles.isEmpty) return null;

    final now = DateTime.now();

    final filtered = tiles.where((tile) => !dismissedIds.contains(tile.id)).where((tile) {
      // if no start/end date: treat as always available
      final startsBeforeNow = tile.startDate == null || tile.startDate!.isBefore(now);
      final endsAfterNow = tile.endDate == null || tile.endDate!.isAfter(now);
      return startsBeforeNow && endsAfterNow;
    }).toList();

    if (filtered.isEmpty) return null;

    // Sort by priority ascending (lower = more important)
    filtered.sort((a, b) => a.priority.compareTo(b.priority));

    return filtered.first;
  }
}
