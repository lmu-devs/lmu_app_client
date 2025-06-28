import 'package:json_annotation/json_annotation.dart';

import 'home_featured.dart';
import 'home_tile.dart';

part 'home_data.g.dart';

@JsonSerializable()
class HomeData {
  const HomeData({required this.featured, required this.tiles});

  factory HomeData.fromJson(Map<String, dynamic> json) => _$HomeDataFromJson(json);

  final List<HomeFeatured> featured;
  final List<HomeTile> tiles;

  Map<String, dynamic> toJson() => _$HomeDataToJson(this);
}
