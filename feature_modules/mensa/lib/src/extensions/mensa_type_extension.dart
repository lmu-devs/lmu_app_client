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

  Color backgroundColor(LmuColors colors) {
    final mensaBackgroundColors = colors.mensaColors.backgroundColors;
    return switch (this) {
      MensaType.mensa => mensaBackgroundColors.mensa,
      MensaType.stuBistro => mensaBackgroundColors.stuBistro,
      MensaType.stuCafe => mensaBackgroundColors.stuCafe,
      MensaType.lounge => mensaBackgroundColors.stuLounge,
      MensaType.cafeBar => mensaBackgroundColors.stuLounge,
      MensaType.none => mensaBackgroundColors.stuLounge,
    };
  }

  int compareTo(MensaType other) => index.compareTo(other.index);
}
