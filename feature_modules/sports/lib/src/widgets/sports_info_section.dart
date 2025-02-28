import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/sports_model.dart';
import '../repository/api/models/sports_type.dart';
import '../services/sports_state_service.dart';

class SportsInfoSection extends StatelessWidget {
  const SportsInfoSection({
    super.key,
    required this.sports,
  });

  final SportsModel sports;

  int get _courseNumber => sports.sportTypes
      .map((element) => element.courses.length)
      .fold(0, (previousValue, currentValue) => previousValue + currentValue);

  SportsType get _basicTicket => sports.basicTicket;

  @override
  Widget build(BuildContext context) {
    final sportsLocals = context.locals.sports;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuListItem.base(
            leadingArea: LmuText.body("🎟️"),
            hasHorizontalPadding: false,
            subtitle: _basicTicket.title,
            hasDivider: true,
            trailingArea: LmuIcon(
              icon: LucideIcons.external_link,
              color: context.colors.neutralColors.textColors.weakColors.base,
              size: LmuIconSizes.mediumSmall,
            ),
            onTap: () {
              final url = GetIt.I.get<SportsStateService>().constructUrl(_basicTicket.title);
              LmuUrlLauncher.launchWebsite(context: context, url: url);
            },
          ),
          // LmuListItem.action(
          //   leadingArea: Center(child: LmuText.body("⁉️")),
          //   actionType: LmuListItemAction.chevron,
          //   subtitle: sportsLocals.sportsInfoEntry,
          //   hasHorizontalPadding: false,
          //   hasDivider: true,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const SportsInfoPage(),
          //       ),
          //     );
          //   },
          // ),
          // LmuListItem.action(
          //   leadingArea: Center(child: LmuText.body("🎟️")),
          //   subtitle: sportsLocals.yourTickets,
          //   hasDivider: true,
          //   hasHorizontalPadding: false,
          //   actionType: LmuListItemAction.chevron,
          //   onTap: () {
          //     //const SportsTicketRoute().go(context);
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const SportsTicketsPage(),
          //       ),
          //     );
          //   },
          // ),
          LmuListItem.base(
            leadingArea: Center(child: LmuText.body("🥇")),
            hasHorizontalPadding: false,
            subtitle: "${sports.sportTypes.length} ${sportsLocals.sportTypes}, $_courseNumber ${sportsLocals.courses}",
            hasDivider: true,
          ),
        ],
      ),
    );
  }
}
