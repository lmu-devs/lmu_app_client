import 'package:core/localizations.dart';
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

  int compareTo(MensaType other) => index.compareTo(other.index);
}
