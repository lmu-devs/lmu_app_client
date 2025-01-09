import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'taste_profile_save_model.g.dart';

@JsonSerializable()
class TasteProfileStateModel extends Equatable {
  const TasteProfileStateModel({
    required this.isActive,
    required this.selectedAllergiesPresets,
    required this.selectedPreferencePreset,
    required this.excludedLabels,
  });

  final bool isActive;
  final Set<String> selectedAllergiesPresets;
  final String? selectedPreferencePreset;
  final Set<String> excludedLabels;

  factory TasteProfileStateModel.empty() => const TasteProfileStateModel(
        isActive: false,
        selectedAllergiesPresets: {},
        selectedPreferencePreset: null,
        excludedLabels: {},
      );

  @override
  List<Object?> get props => [isActive, selectedAllergiesPresets, excludedLabels];

  factory TasteProfileStateModel.fromJson(Map<String, dynamic> json) => _$TasteProfileStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasteProfileStateModelToJson(this);

  TasteProfileStateModel copyWith({
    bool? isActive,
    Set<String>? selectedAllergiesPresets,
    String? selectedPreferencePreset,
    Set<String>? excludedLabels,
  }) {
    return TasteProfileStateModel(
      isActive: isActive ?? this.isActive,
      selectedAllergiesPresets: selectedAllergiesPresets ?? this.selectedAllergiesPresets,
      selectedPreferencePreset: selectedPreferencePreset ?? this.selectedPreferencePreset,
      excludedLabels: excludedLabels ?? this.excludedLabels,
    );
  }

  @override
  String toString() {
    return 'TasteProfileStateModel{isActive: $isActive, selectedAllergiesPresets: $selectedAllergiesPresets, selectedPreferencePreset: $selectedPreferencePreset, excludedLabels: $excludedLabels}';
  }
}
