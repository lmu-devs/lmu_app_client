import 'package:json_annotation/json_annotation.dart';

enum MensaType {
  @JsonValue('MENSA')
  mensa,

  @JsonValue('STUBISTRO')
  stuBistro,

  @JsonValue('STUCAFE')
  stuCafe,

  @JsonValue('LOUNGE')
  lounge,

  @JsonValue('NONE')
  none;
}

extension TypeExtension on MensaType {
  int compareTo(MensaType other) => index.compareTo(other.index);
}
