// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureDto _$LectureDtoFromJson(Map<String, dynamic> json) => LectureDto(
      id: LectureDto._intToString(json['publish_id']),
      name: LectureDto._stringFromJson(json['name']),
      facultyId: (json['facultyId'] as num?)?.toInt(),
      description: LectureDto._stringFromJson(json['description']),
      sws: LectureDto._intFromJson(json['sws']),
      semester: LectureDto._stringFromJson(json['semester']),
    );

Map<String, dynamic> _$LectureDtoToJson(LectureDto instance) =>
    <String, dynamic>{
      'publish_id': LectureDto._stringToInt(instance.id),
      'name': LectureDto._stringToJson(instance.name),
      'facultyId': instance.facultyId,
      'description': LectureDto._stringToJson(instance.description),
      'sws': LectureDto._intToJson(instance.sws),
      'semester': LectureDto._stringToJson(instance.semester),
    };
