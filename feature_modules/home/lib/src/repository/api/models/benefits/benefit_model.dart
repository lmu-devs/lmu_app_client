import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'benefit_model.g.dart';

@JsonSerializable()
class BenefitModel extends Equatable {
  const BenefitModel({
    required this.title,
    required this.description,
    required this.url,
    required this.faviconUrl,
    required this.imageUrl,
    required this.aliases,
  });

  final String title;
  final String description;
  final String url;
  @JsonKey(name: 'favicon_url')
  final String faviconUrl;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final List<String> aliases;

  factory BenefitModel.fromJson(Map<String, dynamic> json) => _$BenefitModelFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitModelToJson(this);

  @override
  List<Object?> get props => [
        title,
        description,
        url,
        faviconUrl,
        imageUrl,
        aliases,
      ];
}
