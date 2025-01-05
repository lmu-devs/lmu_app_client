import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../../repository/api/models/mensa/mensa_type.dart';

class MensaTag extends StatelessWidget {
  const MensaTag({
    super.key,
    required this.type,
  });

  final MensaType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final localizations = context.locals.canteen;

    final tagData = type.getTagData(colors, localizations);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
      decoration: BoxDecoration(
        color: tagData.backgroundColor,
        borderRadius: BorderRadius.circular(LmuSizes.size_4),
      ),
      child: LmuText.bodySmall(
        tagData.text,
        color: tagData.textColor,
      ),
    );
  }
}

extension TagColors on MensaType {
  ({Color backgroundColor, Color textColor, String text}) getTagData(
      LmuColors colors, CanteenLocalizations localizations) {
    return (
      backgroundColor: _backgroundColor(colors),
      textColor: _textColor(colors),
      text: _text(localizations),
    );
  }

  Color _backgroundColor(LmuColors colors) {
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
      case MensaType.espressoBar:
        return mensaBackgroundColors.stuLounge;
      default:
        return Colors.transparent;
    }
  }

  Color _textColor(LmuColors colors) {
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
      case MensaType.espressoBar:
        return mensaTextColors.stuLounge;
      default:
        return Colors.transparent;
    }
  }

  String _text(CanteenLocalizations localizations) {
    switch (this) {
      case MensaType.mensa:
        return localizations.mensaTypeMensa;
      case MensaType.stuBistro:
        return localizations.mensaTypeStuBistro;
      case MensaType.stuCafe:
        return localizations.mensaTypeStuCafe;
      case MensaType.lounge:
        return localizations.mensaTypeLounge;
      case MensaType.espressoBar:
        return localizations.mensaTypeEspressoBar;
      default:
        return '';
    }
  }
}
