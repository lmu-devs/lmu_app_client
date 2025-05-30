import 'package:json_annotation/json_annotation.dart';

enum MensaType {
  @JsonValue('MENSA')
  mensa,

  @JsonValue('STUBISTRO')
  stuBistro,

  @JsonValue('STUCAFE')
  stuCafe,

  @JsonValue('STULOUNGE')
  lounge,

  @JsonValue('cafeBar')
  cafeBar,

  @JsonValue('NONE')
  none;
}
