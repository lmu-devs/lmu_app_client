import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../util/screening_filter_keys.dart';

class CinemaFilterButtonRow extends StatelessWidget {
  const CinemaFilterButtonRow({
    Key? key,
    required this.activeFilter,
    required this.onFilterSelected,
  }) : super(key: key);

  final String? activeFilter;
  final ValueChanged<String?> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LmuButtonRow(
        hasHorizontalPadding: false,
        buttons: [
          LmuButton(
            title: 'Watchlist',
            leadingWidget: StarIcon(
              key: const ValueKey(ScreeningFilterKeys.watchlist),
              isActive: activeFilter == ScreeningFilterKeys.watchlist,
              disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
            ),
            emphasis: activeFilter == ScreeningFilterKeys.watchlist ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeFilter == ScreeningFilterKeys.watchlist ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap(ScreeningFilterKeys.watchlist),
          ),
          LmuButton(
            title: context.locals.cinema.munich,
            emphasis: activeFilter == ScreeningFilterKeys.munich ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeFilter == ScreeningFilterKeys.munich ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap(ScreeningFilterKeys.munich),
          ),
          LmuButton(
            title: 'Garching',
            emphasis: activeFilter == ScreeningFilterKeys.garching ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeFilter == ScreeningFilterKeys.garching ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap(ScreeningFilterKeys.garching),
          ),
        ],
      ),
    );
  }

  void _onButtonTap(String filter) {
    if (activeFilter == filter) {
      onFilterSelected(null);
    } else {
      onFilterSelected(filter);
    }
  }
}
