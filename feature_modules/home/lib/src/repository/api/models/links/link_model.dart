import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link_model.g.dart';

@JsonSerializable()
class LinkModel extends Equatable {

  factory LinkModel.fromJson(Map<String, dynamic> json) => _$LinkModelFromJson(json);

  const LinkModel({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.faviconUrl,
    required this.faculties,
    required this.types,
    required this.aliases,
    required this.rating,
  });

  final String id;
  final String title;
  final String description;
  final String url;
  @JsonKey(name: 'favicon_url')
  final String? faviconUrl;
  final List<String> faculties;
  final List<String> types;
  final List<String> aliases;
  final RatingModel rating;

  Map<String, dynamic> toJson() => _$LinkModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        url,
        faviconUrl,
        faculties,
        types,
        rating,
      ];
}
