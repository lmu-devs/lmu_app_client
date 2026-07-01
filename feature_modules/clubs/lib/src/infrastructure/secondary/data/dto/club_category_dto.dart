import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'club_category_dto.g.dart';

@JsonSerializable()
class ClubCategoryDto extends Equatable {
  const ClubCategoryDto({
    required this.id,
    required this.title,
    this.description,
    required this.emoji,
    required this.clubIds,
  });

  factory ClubCategoryDto.fromJson(Map<String, dynamic> json) => _$ClubCategoryDtoFromJson(json);

  final String id;
  final String title;
  final String? description;
  final String emoji;
  @JsonKey(name: 'club_ids')
  final List<String> clubIds;

  Map<String, dynamic> toJson() => _$ClubCategoryDtoToJson(this);

  @override
  List<Object?> get props => [id, title, description, emoji, clubIds];
}
