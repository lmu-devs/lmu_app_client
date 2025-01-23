import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'description_model.g.dart';

@JsonSerializable()
class DescriptionModel extends Equatable {
  const DescriptionModel({
    required this.emoji,
    required this.description,
  });

  final String emoji;
  final String description;

  @override
  List<Object> get props => [
    emoji,
    description,
  ];

  factory DescriptionModel.fromJson(Map<String, dynamic> json) => _$DescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DescriptionModelToJson(this);
}