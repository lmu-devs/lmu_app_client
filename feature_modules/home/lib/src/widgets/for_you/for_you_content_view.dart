import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/sports.dart';

import '../../repository/api/models/home_model.dart';
import '../widgets.dart';

class ForYouContentView extends StatelessWidget {
  const ForYouContentView({
    super.key,
    required this.homeData,
    required this.pageController,
  });

  final HomeModel homeData;
  final PageController pageController;

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
                actionTitle: context.locals.app.showAll,
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
        GetIt.I.get<CinemaService>().movieTeaserList(
            headlineActionText: context.locals.app.showAll, headlineActionFunction: () => pageController.jumpToPage(2)),
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
