// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) => FeedbackModel(
      type: json['type'] as String,
      rating: json['rating'] as String?,
      message: json['message'] as String?,
      screen: json['screen'] as String,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FeedbackModelToJson(FeedbackModel instance) => <String, dynamic>{
      'type': instance.type,
      'rating': instance.rating,
      'message': instance.message,
      'screen': instance.screen,
      'tags': instance.tags,
    };
