// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuDayModel _$MenuDayModelFromJson(Map<String, dynamic> json) => MenuDayModel(
      canteenId: json['canteen_id'] as String,
      date: json['date'] as String,
      menuItems:
          (json['dishes'] as List<dynamic>).map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MenuDayModelToJson(MenuDayModel instance) => <String, dynamic>{
      'canteen_id': instance.canteenId,
      'date': instance.date,
      'dishes': instance.menuItems,
    };
