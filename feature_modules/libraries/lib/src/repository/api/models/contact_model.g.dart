// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      phone: (json['phone'] as List<dynamic>)
          .map((e) => PhoneModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      website: json['website'] == null
          ? null
          : WebsiteModel.fromJson(json['website'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'website': instance.website,
    };
