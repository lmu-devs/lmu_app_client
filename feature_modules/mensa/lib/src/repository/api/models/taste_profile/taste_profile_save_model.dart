import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'taste_profile_save_model.g.dart';

@JsonSerializable()
class TasteProfileStateModel extends Equatable {
  const TasteProfileStateModel({
    required this.isActive,
    required this.selectedPresets,
    required this.excludedLabels,
  });

  final bool isActive;
  final Set<String> selectedPresets;
  final Set<String> excludedLabels;

  factory TasteProfileStateModel.empty() => const TasteProfileStateModel(
        isActive: false,
        selectedPresets: {},
        excludedLabels: {},
      );

  @override
  List<Object?> get props => [isActive, selectedPresets, excludedLabels];

  factory TasteProfileStateModel.fromJson(Map<String, dynamic> json) => _$TasteProfileStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasteProfileStateModelToJson(this);

  TasteProfileStateModel copyWith({
    bool? isActive,
    Set<String>? selectedPresets,
    Set<String>? excludedLabels,
  }) {
    return TasteProfileStateModel(
      isActive: isActive ?? this.isActive,
      selectedPresets: selectedPresets ?? this.selectedPresets,
      excludedLabels: excludedLabels ?? this.excludedLabels,
    );
  }
}
