import 'package:core/localizations.dart';

import '../repository/api/models/mensa/mensa_type.dart';

extension MensaTypeNameMapper on MensaType {
  String text(CanteenLocalizations localizations) {
    switch (this) {
      case MensaType.mensa:
        return localizations.mensaTypeMensa;
      case MensaType.stuBistro:
        return localizations.mensaTypeStuBistro;
      case MensaType.stuCafe:
        return localizations.mensaTypeStuCafe;
      case MensaType.lounge:
        return localizations.mensaTypeLounge;
      case MensaType.cafeBar:
        return localizations.mensaTypeCafeBar;
      default:
        return '';
    }
  }
}
