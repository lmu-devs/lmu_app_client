import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'taste_profile_label.dart';
import 'taste_profile_preset.dart';

part 'taste_profile_model.g.dart';

@JsonSerializable()
class TasteProfileModel extends Equatable {
  @JsonKey(name: 'alergies_presets')
  final List<TasteProfilePreset> allergiesPresets;
  @JsonKey(name: 'preferences_presets')
  final List<TasteProfilePreset> preferencesPresets;
  @JsonKey(name: 'sorted_labels')
  final List<TasteProfileLabel> sortedLabels;

  const TasteProfileModel({
    required this.allergiesPresets,
    required this.preferencesPresets,
    required this.sortedLabels,
  });

  factory TasteProfileModel.fromJson(Map<String, dynamic> json) => _$TasteProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$TasteProfileModelToJson(this);

  @override
  List<Object?> get props => [allergiesPresets, preferencesPresets, sortedLabels];
}
