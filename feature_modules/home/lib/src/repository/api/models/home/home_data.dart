import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'home_tile.dart';

@JsonSerializable()
class HomeData extends Equatable {
  final List<String> featured;
  final List<HomeTile> tiles;

  const HomeData({required this.featured, required this.tiles});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      featured: List<String>.from(json['featured'] ?? []),
      tiles: (json['tiles'] as List<dynamic>).map((tile) => HomeTile.fromJson(tile as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'featured': featured,
        'tiles': tiles.map((tile) => tile.toJson()).toList(),
      };

  @override
  List<Object?> get props => [featured, tiles];
}
