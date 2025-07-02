import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/feature_flag_impl.dart';

part 'feature_flag_dto.g.dart';

@JsonSerializable()
class FeatureFlagDto extends Equatable {
  const FeatureFlagDto({
    required this.id,
    required this.isActive,
  });

  factory FeatureFlagDto.fromJson(Map<String, dynamic> json) => _$FeatureFlagDtoFromJson(json);

  final String id;
  @JsonKey(name: 'enabled')
  final bool isActive;

  FeatureFlagImpl toDomain() => FeatureFlagImpl(
        id: id,
        isActive: isActive,
      );

  Map<String, dynamic> toJson() => _$FeatureFlagDtoToJson(this);

  @override
  List<Object> get props => [id, isActive];
}
