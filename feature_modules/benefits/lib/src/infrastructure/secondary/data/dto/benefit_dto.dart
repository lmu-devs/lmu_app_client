import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/benefit.dart';

part 'benefit_dto.g.dart';

@JsonSerializable()
class BenefitDto extends Equatable {
  const BenefitDto({
    required this.title,
    required this.description,
    required this.url,
    required this.aliases,
    this.faviconUrl,
    this.imageUrl,
  });

  final String title;
  final String description;
  final String url;
  final List<String> aliases;
  @JsonKey(name: 'favicon_url')
  final String? faviconUrl;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  Benefit toDomain() => Benefit(
        title: title,
        description: description,
        url: url,
        faviconUrl: faviconUrl,
        imageUrl: imageUrl,
        aliases: aliases,
      );

  factory BenefitDto.fromJson(Map<String, dynamic> json) => _$BenefitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitDtoToJson(this);

  @override
  List<Object?> get props => [title, description, url, faviconUrl, imageUrl, aliases];
}
