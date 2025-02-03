import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_api/cinema.dart';
import 'package:shared_api/sports.dart';
import 'package:shared_api/timeline.dart';

import '../../repository/api/models/home_model.dart';
import '../widgets.dart';
import 'temporary_benefits_data.dart';

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
        const SizedBox(height: LmuSizes.size_24),
        //GetIt.I.get<MensaService>().featuredMensaContent,
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
        GetIt.I.get<CinemaService>().movieTeaserList(
            headlineActionText: context.locals.app.showAll, headlineActionFunction: () => pageController.jumpToPage(2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadline.base(title: "Vorteile und Angebote"),
        ),
        GetIt.I.get<SportsService>().entryPoint,
        const SizedBox(height: LmuSizes.size_32),
        const _BenefitsCard(),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}

class _BenefitsCard extends StatelessWidget {
  const _BenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: LmuContentTile(
        content: benefits.mapIndexed(
          (index, benefit) {
            return LmuListItem.base(
              title: benefit.title,
              subtitle: benefit.subtitle,
              onTap: () {
                LmuUrlLauncher.launchWebsite(
                  context: context,
                  url: benefit.url,
                );
              },
              mainContentAlignment: MainContentAlignment.top,
              leadingArea: Padding(
                padding: const EdgeInsets.only(top: LmuSizes.size_2),
                child: LmuIcon(
                  icon: benefit.icon,
                  size: LmuSizes.size_20,
                ),
              ),
              trailingArea: Padding(
                padding: const EdgeInsets.only(top: LmuSizes.size_2),
                child: LmuIcon(
                  icon: LucideIcons.external_link,
                  size: LmuSizes.size_20,
                  color: context.colors.neutralColors.textColors.weakColors.base,
                ),
              ),
              hasDivider: index != benefits.length - 1,
            );
          },
        ).toList(),
      ),
    );
  }
}
