import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image_dto.dart';

part 'benefit_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BenefitDto extends Equatable {
  const BenefitDto({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.faviconUrl,
    this.image,
  });

  final String id;
  final String title;
  final String description;
  final String url;
  @JsonKey(name: 'favicon_url')
  final String faviconUrl;
  final ImageDto? image;

  factory BenefitDto.fromJson(Map<String, dynamic> json) => _$BenefitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitDtoToJson(this);

  @override
  List<Object?> get props => [id, title, description, url, faviconUrl, image];
}
