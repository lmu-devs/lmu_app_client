import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_model.g.dart';

@JsonSerializable()
class PriceModel extends Equatable {
  final String category;
  @JsonKey(name: 'base_price')
  final int basePrice;
  @JsonKey(name: 'price_per_unit')
  final int pricePerUnit;
  final String unit;

  const PriceModel({
    required this.category,
    required this.basePrice,
    required this.pricePerUnit,
    required this.unit,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => _$PriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);

  @override
  List<Object?> get props => [
        category,
        basePrice,
        pricePerUnit,
        unit,
      ];
}