import 'package:json_annotation/json_annotation.dart';

enum SortOption {
  @JsonValue('ALPHABETICALLY')
  alphabetically,
  @JsonValue('DISTANCE')
  distance,
  @JsonValue('RATING')
  rating,
  @JsonValue('TYPE')
  type,
}
