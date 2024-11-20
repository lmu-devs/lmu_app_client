import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'rating_model.dart';
import 'price_model.dart';

part 'dish_model.g.dart';

@JsonSerializable()
class DishModel extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'dish_type')
  final String dishType;
  @JsonKey(name: 'rating')
  final RatingModel ratingModel;
  @JsonKey(name: 'price_simple')
  final String priceSimple;
  final List<String> labels;
  final List<PriceModel> prices;

  const DishModel({
    required this.id,
    required this.name,
    required this.dishType,
    required this.ratingModel,
    required this.priceSimple,
    required this.labels,
    required this.prices,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) => _$DishModelFromJson(json);

  Map<String, dynamic> toJson() => _$DishModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        dishType,
        ratingModel,
        priceSimple,
        labels,
        prices,
      ];
}
