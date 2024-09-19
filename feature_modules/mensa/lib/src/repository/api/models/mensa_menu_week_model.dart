import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'mensa_menu_day_model.dart';

part 'mensa_menu_week_model.g.dart';

@JsonSerializable()
class MensaMenuWeekModel extends Equatable {
  final int week;
  final int year;
  @JsonKey(name: 'canteen_id')
  final String canteenId;
  @JsonKey(name: 'menu_days')
  final List<MensaMenuDayModel> mensaMenuDayModels;

  const MensaMenuWeekModel({
    required this.week,
    required this.year,
    required this.canteenId,
    required this.mensaMenuDayModels,
  });

  factory MensaMenuWeekModel.fromJson(Map<String, dynamic> json) => _$MensaMenuWeekModelFromJson(json);

  Map<String, dynamic> toJson() => _$MensaMenuWeekModelToJson(this);

  @override
  List<Object?> get props => [
        week,
        year,
        canteenId,
        mensaMenuDayModels,
      ];
}
