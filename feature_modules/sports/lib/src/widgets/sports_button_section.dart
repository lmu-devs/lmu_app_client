import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/sports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../services/sports_state_service.dart';

class SportsButtonSection extends StatefulWidget {
  const SportsButtonSection({super.key});

  @override
  State<SportsButtonSection> createState() => _SportsButtonSectionState();
}

class _SportsButtonSectionState extends State<SportsButtonSection> {
  final _sportsStateService = GetIt.I.get<SportsStateService>();

  @override
  Widget build(BuildContext context) {
    final locals = context.locals.app;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadline.base(
              title: context.locals.sports.sportOverviewTitle),
        ),
        ValueListenableBuilder<Map<SportsFilterOption, bool>>(
          valueListenable: _sportsStateService.filterOptionsNotifier,
          builder: (context, activeFilters, _) {
            final isAvailableActive =
                activeFilters[SportsFilterOption.available] ?? false;
            final isTodayActive =
                activeFilters[SportsFilterOption.today] ?? false;

            return LmuButtonRow(
              buttons: [
                LmuIconButton(
                  icon: LucideIcons.search,
                  onPressed: () => const SportsSearchRoute().go(context),
                ),
                LmuButton(
                  title: locals.available,
                  emphasis: isAvailableActive
                      ? ButtonEmphasis.primary
                      : ButtonEmphasis.secondary,
                  action: isAvailableActive
                      ? ButtonAction.contrast
                      : ButtonAction.base,
                  onTap: () {
                    _sportsStateService
                        .toggleFilter(SportsFilterOption.available);
                  },
                ),
                LmuButton(
                  title: locals.today,
                  emphasis: isTodayActive
                      ? ButtonEmphasis.primary
                      : ButtonEmphasis.secondary,
                  action:
                      isTodayActive ? ButtonAction.contrast : ButtonAction.base,
                  onTap: () {
                    _sportsStateService.toggleFilter(SportsFilterOption.today);
                  },
                ),
              ],
            );
          },
        ),
        const SizedBox(height: LmuSizes.size_16),
      ],
    );
  }
}
