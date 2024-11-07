import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'taste_profile_label.dart';
import 'taste_profile_preset.dart';

part 'taste_profile_model.g.dart';

@JsonSerializable()
class TasteProfileModel extends Equatable {
  final int version;
  final List<TasteProfilePreset> presets;
  @JsonKey(name: 'sorted_labels')
  final List<TasteProfileLabel> sortedLabels;

  const TasteProfileModel({
    required this.version,
    required this.presets,
    required this.sortedLabels,
  });

  factory TasteProfileModel.fromJson(Map<String, dynamic> json) => _$TasteProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$TasteProfileModelToJson(this);

  @override
  List<Object?> get props => [version, presets, sortedLabels];
}
