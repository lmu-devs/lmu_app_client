import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';

class SportsLoadingView extends StatelessWidget {
  const SportsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final sportsLocals = context.locals.sports;

    const loadingTileCount = [6, 4, 2, 3];

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SportsTicketsPage(),
                      ),
                    );
                    //const SportsTicketRoute().go(context);
                  },
                ),
                LmuListItemLoading(
                  leadingArea: Center(child: LmuText.body("🥇")),
                  subtitleLength: 4,
                  hasHorizontalPadding: false,
                  hasDivier: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(LmuSizes.size_16),
            child: Column(
              children: List.generate(
                loadingTileCount.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LmuTileHeadlineLoading(titleLength: 1),
                    LmuContentTile(
                      content: List.generate(
                        loadingTileCount[index],
                        (index) => const LmuListItemLoading(
                          leadingArea: LmuStatusDot(),
                          titleLength: 2,
                          trailingTitleLength: 1,
                          action: LmuListItemAction.chevron,
                        ),
                      ),
                    ),
                    const SizedBox(height: LmuSizes.size_32),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_64)
        ],
      ),
    );
  }
}
