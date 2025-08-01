import 'dart:ui';

import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:shared_api/mensa.dart';

extension MensaTypeNameMapper on MensaType {
  String text(CanteenLocalizations localizations) {
    return switch (this) {
      MensaType.mensa => localizations.mensaTypeMensa,
      MensaType.stuBistro => localizations.mensaTypeStuBistro,
      MensaType.stuCafe => localizations.mensaTypeStuCafe,
      MensaType.lounge => localizations.mensaTypeLounge,
      MensaType.cafeBar => localizations.mensaTypeCafeBar,
      MensaType.none => localizations.mensaTypeMensa,
    };
  }

  Color? backgroundColor(LmuColors colors) {
    final mensaBackgroundColors = colors.customColors.backgroundColors;
    return switch (this) {
      MensaType.mensa => mensaBackgroundColors.green,
      MensaType.stuBistro => mensaBackgroundColors.pink,
      MensaType.stuCafe => mensaBackgroundColors.amber,
      MensaType.lounge => mensaBackgroundColors.stuLounge,
      MensaType.cafeBar => mensaBackgroundColors.stuLounge,
      MensaType.none => null,
    };
  }

  int compareTo(MensaType other) => index.compareTo(other.index);
}
