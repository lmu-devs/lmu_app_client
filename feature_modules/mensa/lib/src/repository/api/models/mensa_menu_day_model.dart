import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dish_model.dart';

part 'mensa_menu_day_model.g.dart';

@JsonSerializable()
class MensaMenuDayModel extends Equatable {
  final String date;
  @JsonKey(name: 'dishes')
  final List<DishModel> dishModels;

  const MensaMenuDayModel({
    required this.date,
    required this.dishModels,
  });

  factory MensaMenuDayModel.fromJson(Map<String, dynamic> json) {
    final dishesJson = json['dishes'] as List<dynamic>?;
    final List<DishModel> dishModels = (dishesJson != null && dishesJson.isNotEmpty)
        ? dishesJson.map((dishJson) => DishModel.fromJson(dishJson as Map<String, dynamic>)).toList()
        : [];

    return MensaMenuDayModel(
      date: json['date'] as String,
      dishModels: dishModels,
    );
  }

  Map<String, dynamic> toJson() => _$MensaMenuDayModelToJson(this);

  @override
  List<Object?> get props => [
        date,
        dishModels,
      ];
}
