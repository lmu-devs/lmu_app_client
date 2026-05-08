import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'benefit_dto.dart';
import 'benefit_type_dto.dart';

part 'benefits_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BenefitsDto extends Equatable {
  const BenefitsDto({
    required this.benefitTypes,
    required this.benefits,
  });

  factory BenefitsDto.fromJson(Map<String, dynamic> json) => _$BenefitsDtoFromJson(json);

  @JsonKey(name: 'benefit_types')
  final List<BenefitTypeDto> benefitTypes;
  final List<BenefitDto> benefits;

  Map<String, dynamic> toJson() => _$BenefitsDtoToJson(this);

  @override
  List<Object?> get props => [benefitTypes, benefits];
}
