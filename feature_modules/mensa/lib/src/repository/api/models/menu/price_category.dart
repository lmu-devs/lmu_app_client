import 'package:json_annotation/json_annotation.dart';

enum PriceCategory {
  @JsonValue('STUDENTS')
  students,
  @JsonValue('STAFF')
  staff,
  @JsonValue('GUESTS')
  guests,
}
