// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaStatus _$MensaStatusFromJson(Map<String, dynamic> json) => MensaStatus(
      isLectureFree: json['is_lecture_free'] as bool,
      isClosed: json['is_closed'] as bool,
      isTemporaryClosed: json['is_temporary_closed'] as bool,
    );

Map<String, dynamic> _$MensaStatusToJson(MensaStatus instance) => <String, dynamic>{
      'is_lecture_free': instance.isLectureFree,
      'is_closed': instance.isClosed,
      'is_temporary_closed': instance.isTemporaryClosed,
    };
