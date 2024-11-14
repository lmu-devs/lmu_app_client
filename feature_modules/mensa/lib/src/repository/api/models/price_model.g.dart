// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      category: json['category'] as String,
      basePrice: (json['base_price'] as num).toDouble(),
      pricePerUnit: (json['price_per_unit'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'base_price': instance.basePrice,
      'price_per_unit': instance.pricePerUnit,
      'unit': instance.unit,
    };
