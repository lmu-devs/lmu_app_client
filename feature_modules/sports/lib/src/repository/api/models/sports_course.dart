// course.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sports_location.dart';
import 'sports_price.dart';
import 'sports_time_slot.dart';

part 'sports_course.g.dart';

@JsonSerializable()
class SportsCourse extends Equatable {
  const SportsCourse({
    required this.id,
    required this.title,
    required this.isAvailable,
    required this.startDate,
    required this.endDate,
    required this.instructor,
    required this.timeSlots,
    required this.price,
    this.location,
  });

  final String id;
  final String title;
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  final String instructor;
  @JsonKey(name: 'time_slots')
  final List<SportsTimeSlot> timeSlots;
  final SportsPrice price;
  final SportsLocation? location;

  factory SportsCourse.fromJson(Map<String, dynamic> json) => _$SportsCourseFromJson(json);

  Map<String, dynamic> toJson() => _$SportsCourseToJson(this);

  @override
  List<Object?> get props => [title, isAvailable, startDate, endDate, instructor, timeSlots, price, location];
}
