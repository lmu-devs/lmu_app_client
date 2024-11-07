import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'taste_profile_label_item.g.dart';

@JsonSerializable()
class TasteProfileLabelItem extends Equatable {
  @JsonKey(name: 'enum_name')
  final String enumName;
  final Map<String, String> text;
  @JsonKey(name: 'emoji_abbreviation')
  final String? emojiAbbreviation;
  @JsonKey(name: 'text_abbreviation')
  final String? textAbbreviation;

  const TasteProfileLabelItem({
    required this.enumName,
    required this.text,
    this.emojiAbbreviation,
    this.textAbbreviation,
  });

  factory TasteProfileLabelItem.fromJson(Map<String, dynamic> json) => _$TasteProfileLabelItemFromJson(json);
  Map<String, dynamic> toJson() => _$TasteProfileLabelItemToJson(this);

  @override
  List<Object?> get props => [enumName, text, emojiAbbreviation, textAbbreviation];
}
