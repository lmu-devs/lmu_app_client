import 'package:json_annotation/json_annotation.dart';

enum SortOption {
  @JsonValue('ALPHABETICALLY')
  alphabetically,
  @JsonValue('RATING')
  rating,
}
