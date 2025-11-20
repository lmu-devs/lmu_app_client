// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) => SessionDto(
      caption: json['caption'] as String,
      startingTime: json['starting_time'] as String,
      endingTime: json['ending_time'] as String,
      rhythm: json['rythm'] as String,
      weekday: json['weekday'] as String?,
      timingType: json['timing_type'] as String?,
      durationStart: json['duration_start'] as String?,
      durationEnd: json['duration_end'] as String?,
      room: json['room'] as String?,
      lecturer: json['lecturer'] as String?,
      remark: json['remark'] as String?,
      cancelledDates: json['cancelled_dates'] as String?,
    );

Map<String, dynamic> _$SessionDtoToJson(SessionDto instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'weekday': instance.weekday,
      'starting_time': instance.startingTime,
      'ending_time': instance.endingTime,
      'timing_type': instance.timingType,
      'rythm': instance.rhythm,
      'duration_start': instance.durationStart,
      'duration_end': instance.durationEnd,
      'room': instance.room,
      'lecturer': instance.lecturer,
      'remark': instance.remark,
      'cancelled_dates': instance.cancelledDates,
    };
