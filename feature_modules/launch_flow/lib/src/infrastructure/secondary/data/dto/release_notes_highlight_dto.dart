import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'release_notes_highlight_dto.g.dart';

@JsonSerializable()
class ReleaseNotesHighlightDto extends Equatable {
  const ReleaseNotesHighlightDto({
    required this.emoji,
    required this.title,
    required this.description,
  });

  factory ReleaseNotesHighlightDto.fromJson(Map<String, dynamic> json) => _$ReleaseNotesHighlightDtoFromJson(json);

  final String emoji;
  final String title;
  final String description;

  Map<String, dynamic> toJson() => _$ReleaseNotesHighlightDtoToJson(this);

  @override
  List<Object?> get props => [emoji, title, description];
}
