// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      caption: json['caption'] as String,
      startingTime: json['starting_time'] as String,
      endingTime: json['ending_time'] as String,
      rhythm: json['rhythm'] as String,
      weekday: json['weekday'] as String?,
      timingType: json['timing_type'] as String?,
      durationStart: json['duration_start'] as String?,
      durationEnd: json['duration_end'] as String?,
      roomName: json['room_name'] as String?,
      buildingId: json['building_id'] as String?,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      lecturer: json['lecturer'] as String?,
      remark: json['remark'] as String?,
      cancelledDates: json['cancelled_dates'] as String?,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'weekday': instance.weekday,
      'starting_time': instance.startingTime,
      'ending_time': instance.endingTime,
      'timing_type': instance.timingType,
      'rhythm': instance.rhythm,
      'duration_start': instance.durationStart,
      'duration_end': instance.durationEnd,
      'room_name': instance.roomName,
      'building_id': instance.buildingId,
      'location': instance.location,
      'lecturer': instance.lecturer,
      'remark': instance.remark,
      'cancelled_dates': instance.cancelledDates,
    };
