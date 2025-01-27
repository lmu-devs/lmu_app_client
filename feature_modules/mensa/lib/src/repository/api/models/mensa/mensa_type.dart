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

  @JsonValue('ESPRESSOBAR')
  espressoBar,

  @JsonValue('NONE')
  none;
}

extension TypeExtension on MensaType {
  int compareTo(MensaType other) => index.compareTo(other.index);
}
