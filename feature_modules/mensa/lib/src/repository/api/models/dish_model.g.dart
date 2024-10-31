// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishModel _$DishModelFromJson(Map<String, dynamic> json) => DishModel(
      name: json['name'] as String,
      dishType: json['dish_type'] as String,
      ratingModel: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      priceSimple: json['price_simple'] as String,
      labels: (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      prices: (json['prices'] as List<dynamic>).map((e) => PriceModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$DishModelToJson(DishModel instance) => <String, dynamic>{
      'name': instance.name,
      'dish_type': instance.dishType,
      'rating': instance.ratingModel,
      'price_simple': instance.priceSimple,
      'labels': instance.labels,
      'prices': instance.prices,
    };
