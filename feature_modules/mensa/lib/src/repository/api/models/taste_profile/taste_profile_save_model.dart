// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        isActive: true,
        selectedPresets: {},
        excludedLabels: {},
      );

  @override
  List<Object?> get props => [isActive, selectedPresets, excludedLabels];

  factory TasteProfileStateModel.fromJson(Map<String, dynamic> json) => _$TasteProfileSaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasteProfileSaveModelToJson(this);

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
