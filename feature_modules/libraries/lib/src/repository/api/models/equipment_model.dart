import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'equipment_model.g.dart';

@JsonSerializable()
class EquipmentModel extends Equatable {
  const EquipmentModel({
    required this.title,
    required this.type,
    this.url,
    this.description,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => _$EquipmentModelFromJson(json);

  final String title;
  final String? url;
  final String type;
  final String? description;

  Map<String, dynamic> toJson() => _$EquipmentModelToJson(this);

  @override
  List<Object?> get props => [title, url, type, description];
}
