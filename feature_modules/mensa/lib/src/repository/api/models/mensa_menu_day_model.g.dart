// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_menu_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaMenuDayModel _$MensaMenuDayModelFromJson(Map<String, dynamic> json) =>
    MensaMenuDayModel(
      date: json['date'] as String,
      dishModels: (json['dishes'] as List<dynamic>)
          .map((e) => DishModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MensaMenuDayModelToJson(MensaMenuDayModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'dishes': instance.dishModels,
    };
