import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_api/sports.dart';
import 'package:shared_api/timeline.dart';

import '../../repository/api/models/home_model.dart';
import '../widgets.dart';

class ForYouContentView extends StatelessWidget {
  const ForYouContentView({super.key, required this.homeData});

  final HomeModel homeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: LmuSizes.size_16),
        HomeLinksView(links: homeData.links),
        TuitionFeeWidget(homeData: homeData),
        const SizedBox(height: LmuSizes.size_32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              LmuTileHeadline.action(
                title: "Termine",
                actionTitle: "Alle anzeigen",
                onActionTap: () {
                  GetIt.I.get<TimelineService>().navigateToTimelinePage(context);
                },
              ),
              LmuContentTile(
                content: [
                  LmuListItem.base(
                    subtitle: context.locals.home.lecturePeriod,
                    trailingTitle: DateFormat("dd.MM.yyyy").format(homeData.lectureTime.startDate),
                    mainContentAlignment: MainContentAlignment.center,
                  ),
                  LmuListItem.base(
                    subtitle: context.locals.home.lectureFreePeriod,
                    trailingTitle: DateFormat("dd.MM.yyyy").format(homeData.lectureFreeTime.startDate),
                    mainContentAlignment: MainContentAlignment.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LmuTileHeadline.action(
                title: "Movies",
                actionTitle: "Alle anzeigen",
                onActionTap: () {
                  print("Alle anzeigen");
                },
              ),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(width: LmuSizes.size_8),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _MoveTeaserCard(key: Key("move_$index"));
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: LmuSizes.size_32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadline.base(title: "Vorteile und Angebote"),
        ),
        GetIt.I.get<SportsService>().entryPoint,
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}

class _MoveTeaserCard extends StatelessWidget {
  const _MoveTeaserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 115,
            height: 164,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LmuSizes.size_8),
              image: const DecorationImage(
                image: NetworkImage(
                    "https://images-cdn.ubuy.co.in/63ef0a397f1d781bea0a2464-star-wars-rogue-one-movie-poster.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_8),
          Row(
            children: [
              LmuInTextVisual.text(title: "LMU"),
              const SizedBox(width: LmuSizes.size_4),
              LmuInTextVisual.text(title: "3,50 €"),
              const SizedBox(width: LmuSizes.size_4),
              LmuInTextVisual.text(title: "7,7"),
            ],
          ),
          const SizedBox(height: LmuSizes.size_8),
          LmuText.bodySmall("Heute"),
        ],
      ),
    );
  }
}
