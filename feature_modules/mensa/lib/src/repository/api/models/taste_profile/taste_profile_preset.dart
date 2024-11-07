import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'taste_profile_preset.g.dart';

@JsonSerializable()
class TasteProfilePreset extends Equatable {
  @JsonKey(name: 'enum_name')
  final String enumName;
  final Map<String, String> text;
  @JsonKey(name: 'emoji_abbreviation')
  final String? emojiAbbreviation;
  final List<String> exclude;

  const TasteProfilePreset({
    required this.enumName,
    required this.text,
    required this.emojiAbbreviation,
    required this.exclude,
  });

  factory TasteProfilePreset.fromJson(Map<String, dynamic> json) => _$TasteProfilePresetFromJson(json);

  Map<String, dynamic> toJson() => _$TasteProfilePresetToJson(this);

  @override
  List<Object?> get props => [enumName, text, exclude];
}
