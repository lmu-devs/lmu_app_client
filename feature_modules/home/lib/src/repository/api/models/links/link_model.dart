import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link_model.g.dart';

@JsonSerializable()
class LinkModel extends Equatable {
  const LinkModel({
    required this.title,
    required this.description,
    required this.url,
    required this.faviconUrl,
    required this.types,
    required this.aliases,
  });

  final String title;
  final String description;
  final String url;
  @JsonKey(name: 'favicon_url')
  final String? faviconUrl;
  final List<String> types;
  final List<String> aliases;

  factory LinkModel.fromJson(Map<String, dynamic> json) => _$LinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinkModelToJson(this);

  @override
  List<Object?> get props => [
        title,
        description,
        url,
        faviconUrl,
        types,
        aliases,
      ];
}
