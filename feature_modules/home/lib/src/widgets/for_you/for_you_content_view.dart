import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_api/sports.dart';

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
                  print("Alle anzeigen");
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
        /**Padding(
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
        const SizedBox(height: LmuSizes.size_32),**/
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
