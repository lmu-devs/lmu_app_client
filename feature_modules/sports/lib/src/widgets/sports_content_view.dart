import 'package:collection/collection.dart'; // For groupBy
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../repository/api/models/sports_model.dart';
import '../routes/sports_routes.dart';

class SportsContentView extends StatelessWidget {
  const SportsContentView({super.key, required this.sports});

  final List<SportsModel> sports;

  int get _courseNumber => sports
      .map((element) => element.courses.length)
      .fold(0, (previousValue, currentValue) => previousValue + currentValue);

  Map<String, List<SportsModel>> get _groupedSports => groupBy(sports, (sport) => sport.title[0].toUpperCase());

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LmuButton(
                      emphasis: ButtonEmphasis.secondary,
                      title: "ZHS Website",
                    ),
                  ],
                ),
                const SizedBox(height: LmuSizes.size_16),
                LmuListItem.base(
                  leadingArea: Center(child: LmuText.body("🎟️")),
                  subtitle: "12€ Basis Ticket",
                  hasDivider: true,
                  trailingArea: Icon(
                    LucideIcons.external_link,
                    size: LmuSizes.size_20,
                    color: context.colors.neutralColors.textColors.weakColors.base,
                  ),
                ),
                LmuListItem.base(
                  leadingArea: Center(child: LmuText.body("🥇")),
                  subtitle: "${sports.length} Sportarten, $_courseNumber Kurse",
                  hasDivider: true,
                  trailingArea: Icon(
                    LucideIcons.external_link,
                    size: LmuSizes.size_20,
                    color: context.colors.neutralColors.textColors.weakColors.base,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverStickyHeader(
          header: Container(
            color: context.colors.neutralColors.backgroundColors.base,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: LmuSizes.size_16),
                LmuButtonRow(
                  buttons: [
                    LmuButton(
                      emphasis: ButtonEmphasis.primary,
                      action: ButtonAction.contrast,
                      title: "Alle",
                      onTap: () {},
                    ),
                    LmuButton(
                      emphasis: ButtonEmphasis.secondary,
                      title: "Verfügbar",
                      onTap: () {},
                    ),
                    LmuButton(
                      emphasis: ButtonEmphasis.secondary,
                      title: "Demnächst",
                      onTap: () {},
                    ),
                  ],
                ),
                const Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(height: LmuSizes.size_16),
                    LmuDivider(),
                  ],
                ),
              ],
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final groupEntries = _groupedSports.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
                final groupEntry = groupEntries[index];
                final groupKey = groupEntry.key;
                final sportsInGroup = groupEntry.value;

                return Padding(
                  padding: const EdgeInsets.all(LmuSizes.size_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LmuTileHeadline.base(title: groupKey),
                      LmuContentTile(
                        content: [
                          for (final sport in sportsInGroup)
                            LmuListItem.action(
                              title: sport.title,
                              leadingArea: LmuStatusDot(
                                statusColor: sport.courses.any((course) => course.isAvailable)
                                    ? StatusColor.green
                                    : StatusColor.red,
                              ),
                              actionType: LmuListItemAction.chevron,
                              trailingTitle: '${sport.courses.length} ${sport.courses.length == 1 ? "Kurs" : "Kurse"}',
                              mainContentAlignment: MainContentAlignment.center,
                              onTap: () => SportsDetailsRoute(sport).go(context),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              childCount: _groupedSports.length,
            ),
          ),
        ),
      ],
    );
  }
}
