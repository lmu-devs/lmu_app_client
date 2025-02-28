// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screening_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreeningModel _$ScreeningModelFromJson(Map<String, dynamic> json) =>
    ScreeningModel(
      id: json['id'] as String,
      cinemaId: json['cinema_id'] as String,
      universityId: json['university_id'] as String,
      entryTime: json['entry_time'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String?,
      price: (json['price'] as num).toDouble(),
      isOv: json['is_ov'] as bool?,
      subtitles: json['subtitles'] as String?,
      externalLink: json['external_link'] as String?,
      note: json['note'] as String?,
      movie: MovieModel.fromJson(json['movie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScreeningModelToJson(ScreeningModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cinema_id': instance.cinemaId,
      'university_id': instance.universityId,
      'entry_time': instance.entryTime,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'price': instance.price,
      'is_ov': instance.isOv,
      'subtitles': instance.subtitles,
      'external_link': instance.externalLink,
      'note': instance.note,
      'movie': instance.movie,
    };
