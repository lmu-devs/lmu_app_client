import 'package:json_annotation/json_annotation.dart';

enum ClubType {
  @JsonValue('FS')
  fachschaft,
  @JsonValue('HG')
  hochschulgruppe,
  @JsonValue('RT')
  referat,
  @JsonValue('VN')
  verein,
}
