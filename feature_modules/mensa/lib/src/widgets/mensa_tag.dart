import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../repository/api/models/mensa_type.dart';

class MensaTag extends StatelessWidget {
  const MensaTag({
    super.key,
    required this.type,
  });

  final MensaType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final localizations = context.localizations;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LmuSizes.small,
      ),
      decoration: BoxDecoration(
        color: type.backgroundColor(colors),
        borderRadius: BorderRadius.circular(
          LmuSizes.small,
        ),
      ),
      child: LmuText.bodySmall(
        type.text(localizations),
        color: type.textColor(colors),
      ),
    );
  }
}

extension TagColors on MensaType {
  Color backgroundColor(LmuColors colors) {
    final mensaBackgroundColors = colors.mensaColors.backgroundColors;

    switch (this) {
      case MensaType.mensa:
        return mensaBackgroundColors.mensa;
      case MensaType.stuBistro:
        return mensaBackgroundColors.stuBistro;
      case MensaType.stuCafe:
        return mensaBackgroundColors.stuCafe;
      case MensaType.lounge:
        return mensaBackgroundColors.stuLounge;
      default:
        return Colors.transparent;
    }
  }

  Color textColor(LmuColors colors) {
    final mensaTextColors = colors.mensaColors.textColors;
    switch (this) {
      case MensaType.mensa:
        return mensaTextColors.mensa;
      case MensaType.stuBistro:
        return mensaTextColors.stuBistro;
      case MensaType.stuCafe:
        return mensaTextColors.stuCafe;
      case MensaType.lounge:
        return mensaTextColors.stuLounge;
      default:
        return Colors.transparent;
    }
  }

  String text(AppLocalizations localizations) {
    switch (this) {
      case MensaType.mensa:
        return localizations.mensaTypeMensa;
      case MensaType.stuBistro:
        return localizations.mensaTypeStuBistro;
      case MensaType.stuCafe:
        return localizations.mensaTypeStuCafe;
      case MensaType.lounge:
        return localizations.mensaTypeLounge;
      default:
        return '';
    }
  }
}
