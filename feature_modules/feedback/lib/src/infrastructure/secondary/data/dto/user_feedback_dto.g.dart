// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feedback_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeedbackDto _$UserFeedbackDtoFromJson(Map<String, dynamic> json) => UserFeedbackDto(
      type: json['type'] as String,
      screen: json['screen'] as String,
      rating: json['rating'] as String?,
      message: json['message'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      appVersion: json['app_version'] as String?,
      systemVersion: json['system_version'] as String?,
    );

Map<String, dynamic> _$UserFeedbackDtoToJson(UserFeedbackDto instance) => <String, dynamic>{
      'type': instance.type,
      'screen': instance.screen,
      'rating': instance.rating,
      'message': instance.message,
      'tags': instance.tags,
      'app_version': instance.appVersion,
      'system_version': instance.systemVersion,
    };
