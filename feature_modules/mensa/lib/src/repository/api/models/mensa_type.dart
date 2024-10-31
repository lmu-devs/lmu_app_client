import 'package:json_annotation/json_annotation.dart';

enum MensaType {
  @JsonValue('MENSA')
  mensa,

  @JsonValue('STUBISTRO')
  stuBistro,

  @JsonValue('STUCAFE')
  stuCafe,

  @JsonValue('LOUNGE')
  lounge;
}
