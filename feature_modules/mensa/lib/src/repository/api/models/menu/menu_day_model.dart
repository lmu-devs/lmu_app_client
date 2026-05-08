import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'menu_item_model.dart';

part 'menu_day_model.g.dart';

@JsonSerializable()
class MenuDayModel extends Equatable {
  const MenuDayModel({
    required this.canteenId,
    required this.date,
    required this.menuItems,
    required this.isClosed,
  });

  factory MenuDayModel.fromJson(Map<String, dynamic> json) => _$MenuDayModelFromJson(json);

  @JsonKey(name: 'canteen_id')
  final String canteenId;
  final String date;
  @JsonKey(name: 'dishes')
  final List<MenuItemModel> menuItems;
  @JsonKey(name: 'is_closed')
  final bool isClosed;

  Map<String, dynamic> toJson() => _$MenuDayModelToJson(this);

  @override
  List<Object?> get props => [
        canteenId,
        date,
        menuItems,
      ];
}
