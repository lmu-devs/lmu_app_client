import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'taste_profile_label_item.dart';

part 'taste_profile_label.g.dart';

@JsonSerializable()
class TasteProfileLabel extends Equatable {
  const TasteProfileLabel({
    required this.enumCategory,
    required this.name,
    required this.items,
  });

  factory TasteProfileLabel.fromJson(Map<String, dynamic> json) => _$TasteProfileLabelFromJson(json);

  @JsonKey(name: 'enum_category')
  final String enumCategory;
  final String name;
  final List<TasteProfileLabelItem> items;
  Map<String, dynamic> toJson() => _$TasteProfileLabelToJson(this);

  @override
  List<Object?> get props => [enumCategory, name, items];
}
