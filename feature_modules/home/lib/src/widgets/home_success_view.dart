import 'dart:math';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/explore.dart';
import 'package:shared_api/mensa.dart';
import 'package:shared_api/sports.dart';
import 'package:shared_api/timeline.dart';
import 'package:shared_api/wishlist.dart';

import '../pages/benefits_page.dart';
import '../pages/links_page.dart';
import 'links/favorite_link_row.dart';

class HomeSuccessView extends StatelessWidget {
  const HomeSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    final locals = context.locals;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FavoriteLinkRow(),
        Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            children: [
              LmuFeatureTile(
                title: "Featured",
                subtitle: "Something special",
                content: const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(LmuSizes.size_8),
                    child: LmuIcon(
                      icon: LucideIcons.x,
                      size: LmuIconSizes.medium,
                    ),
                  ),
                ),
                hasBorder: true,
                onTap: () {},
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuFeatureTile(
                title: locals.home.dates,
                onTap: () => GetIt.I.get<TimelineService>().navigateToTimelinePage(context),
              ),
              const SizedBox(height: LmuSizes.size_16),
              Row(
                children: [
                  Expanded(
                    child: LmuFeatureTile(
                      title: "News",
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: LmuSizes.size_16),
                  Expanded(
                    child: LmuFeatureTile(
                      title: "Events",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuFeatureTile(
                title: "Mensa",
                onTap: () => GetIt.I.get<MensaService>().navigateToMensaPage(context),
              ),
              const SizedBox(height: LmuSizes.size_16),
              Row(
                children: [
                  Expanded(
                    child: LmuFeatureTile(
                      title: "Roomfinder",
                      onTap: () => GetIt.I.get<ExploreService>().navigateToExplore(context),
                    ),
                  ),
                  const SizedBox(width: LmuSizes.size_16),
                  Expanded(
                    child: LmuFeatureTile(
                      title: "Links",
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LinksPage(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuFeatureTile(
                title: context.locals.sports.sportsTitle,
                padding: EdgeInsets.zero,
                //MarqueeTileContent(texts: sportTypes)],
                onTap: () => GetIt.I.get<SportsService>().navigateToSportsPage(context),
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuFeatureTile(
                title: context.locals.cinema.cinemasTitle,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GetIt.I.get<CinemaService>().cinemaPage,
                  ),
                ),
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuFeatureTile(
                title: "Benefits",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BenefitsPage(),
                  ),
                ),
              ),
              const SizedBox(height: LmuSizes.size_16),
              Row(
                children: [
                  Expanded(
                    child: LmuFeatureTile(
                      title: "Wishlist",
                      onTap: () => GetIt.I.get<WishlistService>().navigateToWishlistPage(context),
                    ),
                  ),
                  const SizedBox(width: LmuSizes.size_16),
                  Expanded(
                    child: LmuFeatureTile(
                      title: "Feedback",
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ],
    );
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
