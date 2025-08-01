import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_api/mensa.dart';

import '../../extensions/mensa_type_extension.dart';

class MensaTag extends StatelessWidget {
  const MensaTag({super.key, required this.type});

  final MensaType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final localizations = context.locals.canteen;

    final tagData = type.getTagData(colors, localizations);
    return LmuInTextVisual.text(
      title: tagData.text,
      backgroundColor: tagData.backgroundColor,
      textColor: tagData.textColor,
    );
  }
}

extension TagColors on MensaType {
  ({Color? backgroundColor, Color? textColor, String text}) getTagData(
      LmuColors colors, CanteenLocalizations localizations) {
    return (
      backgroundColor: backgroundColor(colors),
      textColor: _textColor(colors),
      text: text(localizations),
    );
  }

  Color? _textColor(LmuColors colors) {
    final mensaTextColors = colors.customColors.textColors;
    return switch (this) {
      MensaType.mensa => mensaTextColors.green,
      MensaType.stuBistro => mensaTextColors.pink,
      MensaType.stuCafe => mensaTextColors.amber,
      MensaType.lounge => mensaTextColors.stuLounge,
      MensaType.cafeBar => mensaTextColors.stuLounge,
      MensaType.none => null,
    };
  }
}
