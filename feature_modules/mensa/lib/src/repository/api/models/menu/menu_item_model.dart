import 'package:core/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dish_category.dart';
import 'price_model.dart';

part 'menu_item_model.g.dart';

@JsonSerializable()
class MenuItemModel extends Equatable {
  final int id;
  final String title;
  @JsonKey(name: 'dish_type')
  final String dishType;
  @JsonKey(name: 'dish_category')
  final DishCategory dishCategory;
  @JsonKey(name: 'rating')
  final RatingModel ratingModel;
  @JsonKey(name: 'price_simple')
  final String priceSimple;
  final List<String> labels;
  final List<PriceModel> prices;

  const MenuItemModel({
    required this.id,
    required this.title,
    required this.dishType,
    required this.dishCategory,
    required this.ratingModel,
    required this.priceSimple,
    required this.labels,
    required this.prices,
  });

  factory MenuItemModel.placeholder({String? title}) => MenuItemModel(
        id: 0,
        title: title ?? 'Title',
        dishType: 'E',
        dishCategory: DishCategory.main,
        ratingModel: RatingModel.placeholder(),
        priceSimple: '',
        labels: const [],
        prices: const [],
      );

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => _$MenuItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemModelToJson(this);

  @override
  List<Object?> get props => [
        title,
        dishType,
        ratingModel,
        priceSimple,
        labels,
        prices,
      ];
}
