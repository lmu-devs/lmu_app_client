import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mensa_status.g.dart';

@JsonSerializable()
class MensaStatus extends Equatable {
  const MensaStatus({
    required this.isLectureFree,
    required this.isClosed,
    required this.isTemporaryClosed,
  });

  factory MensaStatus.fromJson(Map<String, dynamic> json) => _$MensaStatusFromJson(json);

  @JsonKey(name: 'is_lecture_free')
  final bool isLectureFree;
  @JsonKey(name: 'is_closed')
  final bool isClosed;
  @JsonKey(name: 'is_temporary_closed')
  final bool isTemporaryClosed;

  Map<String, dynamic> toJson() => _$MensaStatusToJson(this);

  @override
  List<Object?> get props => [
        isLectureFree,
        isClosed,
        isTemporaryClosed,
      ];
}
