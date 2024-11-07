// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'taste_profile_save_model.g.dart';

@JsonSerializable()
class TasteProfileSaveModel extends Equatable {
  const TasteProfileSaveModel({
    required this.isActive,
    required this.selectedPresets,
    required this.excludedLabels,
  });

  final bool isActive;
  final Set<String> selectedPresets;
  final Set<String> excludedLabels;

  factory TasteProfileSaveModel.empty() => const TasteProfileSaveModel(
        isActive: true,
        selectedPresets: {},
        excludedLabels: {},
      );

  @override
  List<Object?> get props => [isActive, selectedPresets, excludedLabels];

  factory TasteProfileSaveModel.fromJson(Map<String, dynamic> json) => _$TasteProfileSaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasteProfileSaveModelToJson(this);

  TasteProfileSaveModel copyWith({
    bool? isActive,
    Set<String>? selectedPresets,
    Set<String>? excludedLabels,
  }) {
    return TasteProfileSaveModel(
      isActive: isActive ?? this.isActive,
      selectedPresets: selectedPresets ?? this.selectedPresets,
      excludedLabels: excludedLabels ?? this.excludedLabels,
    );
  }
}
