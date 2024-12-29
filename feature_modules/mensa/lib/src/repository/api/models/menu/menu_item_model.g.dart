// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemModel _$MenuItemModelFromJson(Map<String, dynamic> json) => MenuItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      dishType: json['dish_type'] as String,
      dishCategory: $enumDecode(_$DishCategoryEnumMap, json['dish_category']),
      ratingModel: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      priceSimple: json['price_simple'] as String,
      labels: (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      prices: (json['prices'] as List<dynamic>).map((e) => PriceModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MenuItemModelToJson(MenuItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'dish_type': instance.dishType,
      'dish_category': _$DishCategoryEnumMap[instance.dishCategory]!,
      'rating': instance.ratingModel,
      'price_simple': instance.priceSimple,
      'labels': instance.labels,
      'prices': instance.prices,
    };

const _$DishCategoryEnumMap = {
  DishCategory.main: 'MAIN',
  DishCategory.soup: 'SOUP',
  DishCategory.sides: 'SIDES',
  DishCategory.dessert: 'DESSERT',
};
