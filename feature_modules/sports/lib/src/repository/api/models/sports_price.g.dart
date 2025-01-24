// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsPrice _$SportsPriceFromJson(Map<String, dynamic> json) => SportsPrice(
      studentPrice: (json['student_price'] as num).toDouble(),
      employeePrice: (json['employee_price'] as num).toDouble(),
      externalPrice: (json['external_price'] as num).toDouble(),
    );

Map<String, dynamic> _$SportsPriceToJson(SportsPrice instance) => <String, dynamic>{
      'student_price': instance.studentPrice,
      'employee_price': instance.employeePrice,
      'external_price': instance.externalPrice,
    };
