import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../services/sports_state_service.dart';

class SportsFilterSection extends StatelessWidget {
  const SportsFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sportsStateService = GetIt.I.get<SportsStateService>();
    final sportsFilterOptions = sportsStateService.filterOptionsNotifier;
    return Container(
      color: context.colors.neutralColors.backgroundColors.base,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          ValueListenableBuilder(
            valueListenable: sportsFilterOptions,
            builder: (context, value, _) {
              final isAllActive = value[SportsFilterOption.all]!;
              final isAvailableActive = value[SportsFilterOption.available]!;
              final isUpcomingActive = value[SportsFilterOption.upcoming]!;

              return LmuButtonRow(
                buttons: [
                  LmuButton(
                    emphasis: isAllActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                    action: isAllActive ? ButtonAction.contrast : ButtonAction.base,
                    title: "Alle",
                    onTap: () => sportsStateService.applyFilter(SportsFilterOption.all),
                  ),
                  LmuButton(
                    emphasis: isAvailableActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                    action: isAvailableActive ? ButtonAction.contrast : ButtonAction.base,
                    title: "Verfügbar",
                    onTap: () => sportsStateService.applyFilter(SportsFilterOption.available),
                  ),
                  LmuButton(
                    emphasis: isUpcomingActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                    action: isUpcomingActive ? ButtonAction.contrast : ButtonAction.base,
                    title: "Demnächst",
                    onTap: () => sportsStateService.applyFilter(SportsFilterOption.upcoming),
                  ),
                ],
              );
            },
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
    );
  }
}
