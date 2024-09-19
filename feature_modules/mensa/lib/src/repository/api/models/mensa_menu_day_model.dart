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

  factory MensaMenuDayModel.fromJson(Map<String, dynamic> json) => _$MensaMenuDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$MensaMenuDayModelToJson(this);

  @override
  List<Object?> get props => [
        date,
        dishModels,
      ];
}
