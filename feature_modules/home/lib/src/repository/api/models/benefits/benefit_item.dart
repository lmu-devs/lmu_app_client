import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'benefit_item.g.dart';

@JsonSerializable()
class BenefitItem extends Equatable {
  const BenefitItem({
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
  final String? faviconUrl;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<String> aliases;

  factory BenefitItem.placeholder() => const BenefitItem(
        title: 'Test title',
        description: 'Test description',
        url: "https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png",
        faviconUrl: null,
        imageUrl: null,
        aliases: [],
      );

  factory BenefitItem.fromJson(Map<String, dynamic> json) => _$BenefitItemFromJson(json);

  Map<String, dynamic> toJson() => _$BenefitItemToJson(this);

  @override
  List<Object?> get props => [title, description, url, faviconUrl, imageUrl, aliases];
}
