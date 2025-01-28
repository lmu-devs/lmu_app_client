import 'package:core/components.dart';
import 'package:flutter/material.dart';

class CinemaFilterButtonRow extends StatelessWidget {
  const CinemaFilterButtonRow({
    Key? key,
    required this.activeCinemaId,
    required this.onCinemaSelected,
  }) : super(key: key);

  final String? activeCinemaId;
  final ValueChanged<String?> onCinemaSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LmuButtonRow(
        hasHorizontalPadding: false,
        buttons: [
          LmuButton(
            title: 'LMU',
            emphasis: activeCinemaId == 'LMU' ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeCinemaId == 'LMU' ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap('LMU'),
          ),
          LmuButton(
            title: 'TUM',
            emphasis: activeCinemaId == 'TUM' ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeCinemaId == 'TUM' ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap('TUM'),
          ),
          LmuButton(
            title: 'HM',
            emphasis: activeCinemaId == 'HM' ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeCinemaId == 'HM' ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap('HM'),
          ),
          LmuButton(
            title: 'TUM Garching',
            emphasis: activeCinemaId == 'TUM_GARCHING' ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            action: activeCinemaId == 'TUM_GARCHING' ? ButtonAction.contrast : ButtonAction.base,
            onTap: () => _onButtonTap('TUM_GARCHING'),
          ),
        ],
      ),
    );
  }

  void _onButtonTap(String cinemaId) {
    if (activeCinemaId == cinemaId) {
      onCinemaSelected(null);
    } else {
      onCinemaSelected(cinemaId);
    }
  }
}
