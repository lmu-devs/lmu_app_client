import 'dart:math';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/benefits.dart';
import 'package:core_routes/cinema.dart';
import 'package:core_routes/home.dart';
import 'package:core_routes/libraries.dart';
import 'package:core_routes/mensa.dart';
import 'package:core_routes/roomfinder.dart';
import 'package:core_routes/sports.dart';
import 'package:core_routes/timeline.dart';
import 'package:core_routes/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import '../../repository/api/models/home/home_featured.dart';
import '../../repository/api/models/home/home_tile.dart';
import '../../repository/api/models/home/home_tile_type.dart';
import '../../service/home_preferences_service.dart';
import '../links/favorite_link_row.dart';
import 'tiles/home_emoji_tile.dart';
import 'tiles/home_featured_tile.dart';

class HomeSuccessView extends StatelessWidget {
  const HomeSuccessView({super.key, required this.tiles, this.featured});

  final List<HomeTile> tiles;
  final HomeFeatured? featured;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FavoriteLinkRow(),
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: ValueListenableBuilder(
              valueListenable: GetIt.I.get<HomePreferencesService>().isFeaturedClosedNotifier,
              builder: (context, isFeaturedClosed, _) {
                final showFeatured = featured != null && !isFeaturedClosed;
                return StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: LmuSizes.size_16,
                  crossAxisSpacing: LmuSizes.size_16,
                  children: [
                    if (showFeatured) HomeFeaturedTile(featured: featured!),
                    ...tiles.map(
                      (tile) {
                        final cellCount = tile.cellCount;
                        return StaggeredGridTile.count(
                          crossAxisCellCount: cellCount.crossAxis,
                          mainAxisCellCount: cellCount.mainAxis,
                          child: LmuFeatureTile(
                            title: tile.localizedTitle(context.locals),
                            subtitle: tile.description,
                            content: tile.content,
                            onTap: tile.onTap(context),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: LmuSizes.size_96),
        ],
      ),
    );
  }
}

extension HomeTileMapper on HomeTile {
  void Function() onTap(BuildContext context) {
    return switch (type) {
      HomeTileType.benefits => () => const BenefitsMainRoute().go(context),
      HomeTileType.cinemas => () => const CinemaMainRoute().go(context),
      HomeTileType.feedback => () =>
          GetIt.I.get<FeedbackApi>().showFeedback(context, type: FeedbackType.general, origin: 'Home General'),
      HomeTileType.roomfinder => () => const RoomfinderMainRoute().go(context),
      HomeTileType.sports => () => const SportsMainRoute().go(context),
      HomeTileType.timeline => () => const TimelineMainRoute().go(context),
      HomeTileType.wishlist => () => const WishlistMainRoute().go(context),
      HomeTileType.links => () => const LinksRoute().go(context),
      HomeTileType.news => () => {_notYetImplemented(context)},
      HomeTileType.events => () => {_notYetImplemented(context)},
      HomeTileType.mensa => () => const MensaMainRoute().go(context),
      HomeTileType.libraries => () => const LibrariesMainRoute().go(context),
      HomeTileType.other => () => {_notYetImplemented(context)},
    };
  }

  String localizedTitle(LmuLocalizations locals) {
    return switch (type) {
      HomeTileType.benefits => locals.home.benefits,
      HomeTileType.cinemas => locals.home.moviesTab,
      HomeTileType.feedback => locals.feedback.feedbackTitle,
      HomeTileType.roomfinder => locals.roomfinder.title,
      HomeTileType.sports => locals.sports.sportsTitle,
      HomeTileType.timeline => locals.timeline.datesTitle,
      HomeTileType.wishlist => locals.wishlist.tabTitle,
      HomeTileType.links => "Links",
      HomeTileType.news => "News",
      HomeTileType.events => "events",
      HomeTileType.mensa => locals.canteen.tabTitle,
      HomeTileType.libraries => locals.libraries.pageTitle,
      HomeTileType.other => "",
    };
  }

  Widget get content {
    return switch (type) {
      HomeTileType.benefits => const HomeEmojiTile(emoji: "💎"),
      HomeTileType.cinemas => const HomeEmojiTile(emoji: "🍿"),
      HomeTileType.feedback => const HomeEmojiTile(emoji: "😕😄🥳"),
      HomeTileType.roomfinder => const HomeEmojiTile(emoji: "🗺️"),
      HomeTileType.sports => const HomeEmojiTile(emoji: "🏈"),
      HomeTileType.timeline => const HomeEmojiTile(emoji: "⏰"),
      HomeTileType.wishlist => const HomeEmojiTile(emoji: "🔮"),
      HomeTileType.links => const HomeEmojiTile(emoji: "🔗"),
      HomeTileType.news => const HomeEmojiTile(emoji: "📰"),
      HomeTileType.events => const HomeEmojiTile(emoji: "🎉"),
      HomeTileType.mensa => const HomeEmojiTile(emoji: "🍽️"),
      HomeTileType.libraries => const HomeEmojiTile(emoji: "📚"),
      HomeTileType.other => Container(),
    };
  }

  void _notYetImplemented(BuildContext context) {
    LmuToast.removeAll(context: context);
    LmuToast.show(context: context, message: "Not implemented yet");
  }

  ({int crossAxis, int mainAxis}) get cellCount {
    switch (size) {
      case 1:
        return (crossAxis: 1, mainAxis: 1);
      case 2:
        return (crossAxis: 2, mainAxis: 1);
      case 3:
        return (crossAxis: 2, mainAxis: 2);

      default:
        throw ArgumentError("Invalid size: $size");
    }
  }
}

class MarqueeTileContent extends StatelessWidget {
  const MarqueeTileContent({super.key, required this.texts, this.height = 170});

  final List<String> texts;
  final double height;

  int get _marqueeCount => height ~/ 34;

  final int groupSize = 4;

  List<List<String>> get _randomTexts {
    if (texts.length < groupSize) {
      throw ArgumentError("List must have at least $groupSize elements.");
    }

    final random = Random();
    final List<String> availableTexts = List.from(texts);
    final List<List<String>> groups = [];

    while (availableTexts.isNotEmpty) {
      if (availableTexts.length < groupSize) {
        availableTexts.addAll(texts);
        availableTexts.shuffle(random);
      }

      final List<String> selectedGroup = availableTexts.sublist(0, groupSize);
      groups.add(selectedGroup);

      availableTexts.removeWhere((item) => selectedGroup.contains(item));
    }

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final customTextStyle = context.colors.neutralColors.textColors.strongColors.disabled;

    return Column(
      children: List.generate(
        _marqueeCount,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            height: 24,
            child: Marquee(
              velocity: 5,
              startPadding: index.isEven ? 15 : 0,
              textDirection: index.isEven ? TextDirection.ltr : TextDirection.rtl,
              secondaryColor: customTextStyle,
              style: context.textTheme.h3,
              blankSpace: 8,
              textList: _randomTexts[index % _randomTexts.length],
            ),
          ),
        ),
      ),
    );
  }
}
