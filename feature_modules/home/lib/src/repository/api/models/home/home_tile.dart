import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'home_default_tile.dart';
import 'home_tile_type.dart';

@JsonSerializable()
abstract class HomeTile extends Equatable {
  final HomeTileType type;
  final int size;
  final String title;
  final String? description;

  const HomeTile({
    required this.type,
    required this.size,
    required this.title,
    this.description,
  });

  static HomeTile fromJson(Map<String, dynamic> json) {
    final type = $enumDecode($HomeTileTypeEnumMap, json['type']);

    return switch (type) {
      HomeTileType.benefits => HomeDefaultTile.fromJson(json),
      HomeTileType.cinemas => HomeDefaultTile.fromJson(json),
      HomeTileType.feedback => HomeDefaultTile.fromJson(json),
      HomeTileType.roomfinder => HomeDefaultTile.fromJson(json),
      HomeTileType.sports => HomeDefaultTile.fromJson(json),
      HomeTileType.timeline => HomeDefaultTile.fromJson(json),
      HomeTileType.wishlist => HomeDefaultTile.fromJson(json),
      HomeTileType.links => HomeDefaultTile.fromJson(json),
      HomeTileType.news => HomeDefaultTile.fromJson(json),
      HomeTileType.events => HomeDefaultTile.fromJson(json),
      HomeTileType.other => HomeDefaultTile.fromJson(json),
      HomeTileType.mensa => HomeDefaultTile.fromJson(json),
      HomeTileType.libraries => HomeDefaultTile.fromJson(json),
    };
  }

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [type, size, title, description];
}

const $HomeTileTypeEnumMap = {
  HomeTileType.benefits: 'BENEFITS',
  HomeTileType.cinemas: 'CINEMAS',
  HomeTileType.feedback: 'FEEDBACK',
  HomeTileType.roomfinder: 'ROOMFINDER',
  HomeTileType.sports: 'SPORTS',
  HomeTileType.timeline: 'TIMELINE',
  HomeTileType.wishlist: 'WISHLIST',
  HomeTileType.links: 'LINKS',
  HomeTileType.news: 'NEWS',
  HomeTileType.events: 'EVENTS',
  HomeTileType.mensa: 'MENSA',
  HomeTileType.libraries: 'LIBRARY',
  HomeTileType.other: 'OTHER',
};
