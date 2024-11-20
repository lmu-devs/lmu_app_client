import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../rating_model.dart';
import 'price_model.dart';

part 'menu_item_model.g.dart';

@JsonSerializable()
class MenuItemModel extends Equatable {
  final int id;
  final String title;
  @JsonKey(name: 'dish_type')
  final String dishType;
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
    required this.ratingModel,
    required this.priceSimple,
    required this.labels,
    required this.prices,
  });

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
