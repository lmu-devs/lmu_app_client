import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/benefit_category.dart';
import 'benefit_dto.dart';

part 'benefit_category_dto.g.dart';

@JsonSerializable()
class BenefitCategoryDto extends Equatable {
  const BenefitCategoryDto({
    required this.title,
    required this.emoji,
    required this.benefits,
    this.description,
  });

  final String title;
  final String emoji;
  final List<BenefitDto> benefits;
  final String? description;

  BenefitCategory toDomain() => BenefitCategory(
        title: title,
        description: description,
        emoji: emoji,
        benefits: benefits.map((e) => e.toDomain()).toList(),
      );

  factory BenefitCategoryDto.fromJson(Map<String, dynamic> json) => _$BenefitCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitCategoryDtoToJson(this);

  @override
  List<Object?> get props => [title, description, emoji, benefits];
}
