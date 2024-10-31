// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      likeCount: (json['like_count'] as num).toInt(),
      isLiked: json['is_liked'] as bool? ?? false,
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) => <String, dynamic>{
      'like_count': instance.likeCount,
      'is_liked': instance.isLiked,
    };
