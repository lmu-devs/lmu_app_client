import 'package:json_annotation/json_annotation.dart';

enum PriceCategory {
  @JsonValue('students')
  students,
  @JsonValue('staff')
  staff,
  @JsonValue('guests')
  guests,
}
