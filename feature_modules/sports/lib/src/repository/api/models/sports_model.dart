import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'sports_type.dart';

part 'sports_model.g.dart';

@JsonSerializable()
class SportsModel extends Equatable {
  const SportsModel({
    required this.baseUrl,
    required this.basicTicket,
    required this.sportTypes,
  });

  @JsonKey(name: 'base_url')
  final String baseUrl;
  @JsonKey(name: 'basic_ticket')
  final SportsType basicTicket;
  @JsonKey(name: 'sport_types')
  final List<SportsType> sportTypes;

  factory SportsModel.fromJson(Map<String, dynamic> json) => _$SportsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SportsModelToJson(this);

  @override
  List<Object?> get props => [baseUrl, basicTicket, sportTypes];
}
