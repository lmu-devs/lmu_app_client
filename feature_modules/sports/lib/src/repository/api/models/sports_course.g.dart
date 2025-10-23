// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsCourse _$SportsCourseFromJson(Map<String, dynamic> json) => SportsCourse(
      id: json['id'] as String,
      title: json['title'] as String,
      isAvailable: json['is_available'] as bool,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      instructor: json['instructor'] as String,
      timeSlots: (json['time_slots'] as List<dynamic>)
          .map((e) => SportsTimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: SportsPrice.fromJson(json['price'] as Map<String, dynamic>),
      url: json['url'] as String,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SportsCourseToJson(SportsCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_available': instance.isAvailable,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'instructor': instance.instructor,
      'time_slots': instance.timeSlots,
      'price': instance.price,
      'url': instance.url,
      'location': instance.location,
    };
