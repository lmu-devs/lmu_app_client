// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeData _$HomeDataFromJson(Map<String, dynamic> json) => HomeData(
      featured:
          (json['featured'] as List<dynamic>).map((e) => HomeFeatured.fromJson(e as Map<String, dynamic>)).toList(),
      tiles: (json['tiles'] as List<dynamic>).map((e) => HomeTile.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$HomeDataToJson(HomeData instance) => <String, dynamic>{
      'featured': instance.featured,
      'tiles': instance.tiles,
    };
