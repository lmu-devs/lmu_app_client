import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feature_flag.g.dart';

@JsonSerializable()
class FeatureFlag extends Equatable {
  factory FeatureFlag.fromJson(Map<String, dynamic> json) => _$FeatureFlagFromJson(json);
  const FeatureFlag({
    required this.id,
    required this.isActive,
  });

  final String id;
  @JsonKey(name: 'enabled')
  final bool isActive;

  Map<String, dynamic> toJson() => _$FeatureFlagToJson(this);

  @override
  List<Object> get props => [id, isActive];
}
