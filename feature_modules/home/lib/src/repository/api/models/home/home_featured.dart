import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_featured.g.dart';

enum HomeUrlType {
  @JsonValue('INTERNAL')
  interal,
  @JsonValue('EXTERNAL')
  external,
}

@JsonSerializable()
class HomeFeatured extends Equatable {
  const HomeFeatured({
    required this.id,
    required this.title,
    required this.priority,
    this.description,
    this.imageUrl,
    this.url,
    this.urlType,
    this.startDate,
    this.endDate,
  });

  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final String? url;
  final HomeUrlType? urlType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int priority;

  factory HomeFeatured.fromJson(Map<String, dynamic> json) => _$HomeFeaturedFromJson(json);

  Map<String, dynamic> toJson() => _$HomeFeaturedToJson(this);

  @override
  List<Object?> get props => [id, title, priority, description, imageUrl, url, urlType, startDate, endDate];
}
