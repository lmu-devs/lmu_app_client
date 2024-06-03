import 'package:core/components.dart';
import 'package:core/constants.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: LmuSizes.small,
      ),
      decoration: BoxDecoration(
        color: type.backgroundColor(context),
        borderRadius: BorderRadius.circular(
          LmuSizes.small,
        ),
      ),
      child: LmuText.body(
        type.name,
        weight: FontWeight.bold,
        color: type.textColor(context),
      ),
    );
  }
}

extension TagColors on MensaType {
  Color backgroundColor(BuildContext context) {
    final mensaBackgroundColors = context.colors.mensaColors.backgroundColors;

    switch (this) {
      case MensaType.mensa:
        return mensaBackgroundColors.mensa;
      case MensaType.stuBistro:
        return mensaBackgroundColors.stuBistro;
      case MensaType.stuCafe:
        return mensaBackgroundColors.stuCafe;
      case MensaType.lounge:
        return mensaBackgroundColors.stuLounge;
    }
  }

  Color textColor(BuildContext context) {
    final mensaTextColors = context.colors.mensaColors.textColors;
    switch (this) {
      case MensaType.mensa:
        return mensaTextColors.mensa;
      case MensaType.stuBistro:
        return mensaTextColors.stuBistro;
      case MensaType.stuCafe:
        return mensaTextColors.stuCafe;
      case MensaType.lounge:
        return mensaTextColors.stuLounge;
    }
  }
}
