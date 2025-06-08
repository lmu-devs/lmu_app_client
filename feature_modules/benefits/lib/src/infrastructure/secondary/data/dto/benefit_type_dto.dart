import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'benefit_type_dto.g.dart';

@JsonSerializable()
class BenefitTypeDto extends Equatable {
  const BenefitTypeDto({
    required this.id,
    required this.title,
    this.description,
    required this.emoji,
    required this.benefitIds,
  });

  final String id;
  final String title;
  final String? description;
  final String emoji;
  @JsonKey(name: 'benefit_ids')
  final List<String> benefitIds;

  factory BenefitTypeDto.fromJson(Map<String, dynamic> json) => _$BenefitTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitTypeDtoToJson(this);

  @override
  List<Object?> get props => [id, title, description, emoji, benefitIds];
}
