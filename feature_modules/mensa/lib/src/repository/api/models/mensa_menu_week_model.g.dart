// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_menu_week_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaMenuWeekModel _$MensaMenuWeekModelFromJson(Map<String, dynamic> json) => MensaMenuWeekModel(
      week: (json['week'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      canteenId: json['canteen_id'] as String,
      mensaMenuDayModels: (json['menu_days'] as List<dynamic>)
          .map((e) => MensaMenuDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MensaMenuWeekModelToJson(MensaMenuWeekModel instance) => <String, dynamic>{
      'week': instance.week,
      'year': instance.year,
      'canteen_id': instance.canteenId,
      'menu_days': instance.mensaMenuDayModels,
    };
