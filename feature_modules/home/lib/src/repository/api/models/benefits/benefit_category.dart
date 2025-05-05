import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'benefit_item.dart';

part 'benefit_category.g.dart';

@JsonSerializable()
class BenefitCategory extends Equatable {
  const BenefitCategory({
    required this.title,
    this.description,
    required this.emoji,
    required this.benefits,
  });

  final String title;
  final String? description;
  final String emoji;
  final List<BenefitItem> benefits;

  factory BenefitCategory.fromJson(Map<String, dynamic> json) => _$BenefitCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitCategoryToJson(this);

  @override
  List<Object?> get props => [title, description, emoji, benefits];
}
