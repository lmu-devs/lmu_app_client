import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'release_notes_highlight_dto.dart';

part 'release_notes_dto.g.dart';

@JsonSerializable()
class RelaseNotesDto extends Equatable {
  const RelaseNotesDto({required this.highlights, this.showPrivacyPolicy = false});

  factory RelaseNotesDto.fromJson(Map<String, dynamic> json) => _$RelaseNotesDtoFromJson(json);

  final List<ReleaseNotesHighlightDto> highlights;
  @JsonKey(name: "show_privacy_policy")
  final bool showPrivacyPolicy;

  Map<String, dynamic> toJson() => _$RelaseNotesDtoToJson(this);

  @override
  List<Object?> get props => [highlights];
}
