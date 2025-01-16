import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/api/models/home_model.dart';
import '../widgets/widgets.dart';

class HomeOverviewView extends StatelessWidget {
  const HomeOverviewView({
    super.key,
    required this.homeData,
  });

  final HomeModel homeData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: LmuSizes.size_24),
        HomeLinksView(links: homeData.links),
        TuitionFeeWidget(homeData: homeData),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16, vertical: LmuSizes.size_16),
          child: LmuContentTile(
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
        ),
        const SizedBox(height: LmuSizes.size_96),
      ]),
    );
  }
}
