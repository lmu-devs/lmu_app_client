import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'club_category_dto.dart';
import 'club_dto.dart';

part 'clubs_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ClubsDto extends Equatable {
  const ClubsDto({
    required this.clubCategories,
    required this.clubs,
  });

  factory ClubsDto.fromJson(Map<String, dynamic> json) => _$ClubsDtoFromJson(json);

  @JsonKey(name: 'club_categories')
  final List<ClubCategoryDto> clubCategories;
  final List<ClubDto> clubs;

  Map<String, dynamic> toJson() => _$ClubsDtoToJson(this);

  @override
  List<Object?> get props => [clubCategories, clubs];
}
