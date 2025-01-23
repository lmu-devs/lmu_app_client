import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sports_model.g.dart';

@JsonSerializable()
class SportsModel extends Equatable {
  const SportsModel({required this.name}); 

  final String name;

  @override
  List<Object> get props => [name];

  factory SportsModel.fromJson(Map<String, dynamic> json) => _$SportsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SportsModelToJson(this);
}