import 'package:json_annotation/json_annotation.dart';

import 'home_tile.dart';

part 'home_default_tile.g.dart';

@JsonSerializable()
class HomeDefaultTile extends HomeTile {
  const HomeDefaultTile({
    required super.size,
    required super.title,
    super.description,
    this.data,
    required super.type,
  }) : super();

  final List<dynamic>? data;

  factory HomeDefaultTile.fromJson(Map<String, dynamic> json) => _$HomeDefaultTileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HomeDefaultTileToJson(this);
}
