// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      firstName: json['first_name'] as String,
      lastName: json['surname'] as String,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'surname': instance.lastName,
      'title': instance.title,
    };
