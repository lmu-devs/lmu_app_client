import 'package:core/components.dart';
import 'package:core/localizations.dart';
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
            title: context.locals.cinema.cityCenter,
            emphasis: activeFilter == ScreeningFilterKeys.cityCenter ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeFilter == ScreeningFilterKeys.cityCenter ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap(ScreeningFilterKeys.cityCenter),
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
