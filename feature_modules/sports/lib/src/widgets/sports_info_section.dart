import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';
import '../repository/api/models/sports_model.dart';

class SportsInfoSection extends StatelessWidget {
  const SportsInfoSection({
    super.key,
    required this.sports,
  });

  final List<SportsModel> sports;

  int get _courseNumber => sports
      .map((element) => element.courses.length)
      .fold(0, (previousValue, currentValue) => previousValue + currentValue);

  @override
  Widget build(BuildContext context) {
    final sportsLocals = context.locals.sports;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          LmuListItem.action(
            leadingArea: Center(child: LmuText.body("⁉️")),
            actionType: LmuListItemAction.chevron,
            subtitle: sportsLocals.sportsInfoEntry,
            hasHorizontalPadding: false,
            hasDivider: true,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SportsInfoPage(),
                ),
              );
            },
          ),
          LmuListItem.action(
            leadingArea: Center(child: LmuText.body("🎟️")),
            subtitle: sportsLocals.yourTickets,
            hasDivider: true,
            hasHorizontalPadding: false,
            actionType: LmuListItemAction.chevron,
            onTap: () {
              //const SportsTicketRoute().go(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SportsTicketsPage(),
                ),
              );
            },
          ),
          LmuListItem.base(
            leadingArea: Center(child: LmuText.body("🥇")),
            hasHorizontalPadding: false,
            subtitle: "${sports.length} ${sportsLocals.sportTypes}, $_courseNumber ${sportsLocals.courses}",
            hasDivider: true,
          ),
        ],
      ),
    );
  }
}
