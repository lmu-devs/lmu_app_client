import 'package:json_annotation/json_annotation.dart';

import 'home_tile.dart';
import 'home_tile_type.dart';

part 'home_benefits_tile.g.dart';

@JsonSerializable()
class HomeBenefitsTile extends HomeTile {
  const HomeBenefitsTile({
    required super.size,
    required super.title,
    super.description,
    this.data,
  }) : super(type: HomeTileType.benefits);

  final String? data;

  factory HomeBenefitsTile.fromJson(Map<String, dynamic> json) => _$HomeBenefitsTileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HomeBenefitsTileToJson(this);

  @override
  List<Object?> get props => super.props..add(data);
}
