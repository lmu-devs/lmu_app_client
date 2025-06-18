import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'poster_model.dart';

part 'trailer_model.g.dart';

@JsonSerializable()
class TrailerModel extends Equatable {
  const TrailerModel({
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.url,
    required this.thumbnail,
    required this.site,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) => _$TrailerModelFromJson(json);

  final String id;
  final String title;
  @JsonKey(name: 'published_at')
  final DateTime publishedAt;
  final String url;
  final PosterModel thumbnail;
  final String site;

  @override
  List<Object?> get props => [
        id,
        title,
        publishedAt,
        url,
        thumbnail,
        site,
      ];

  Map<String, dynamic> toJson() => _$TrailerModelToJson(this);
}
