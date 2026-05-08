// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneModel _$PhoneModelFromJson(Map<String, dynamic> json) => PhoneModel(
      number: json['number'] as String,
      recipient: json['recipient'] as String?,
    );

Map<String, dynamic> _$PhoneModelToJson(PhoneModel instance) => <String, dynamic>{
      'number': instance.number,
      'recipient': instance.recipient,
    };
