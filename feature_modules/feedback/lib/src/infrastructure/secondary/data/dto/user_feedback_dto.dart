import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/user_feedback.dart';

part 'user_feedback_dto.g.dart';

class SystemConfig {
  const SystemConfig({
    required this.appVersion,
    required this.systemVersion,
  });
  final String appVersion;
  final String systemVersion;
}

@JsonSerializable()
class UserFeedbackDto {
  const UserFeedbackDto({
    required this.type,
    required this.screen,
    this.rating,
    this.message,
    this.tags,
    this.appVersion,
    this.systemVersion,
  });

  factory UserFeedbackDto.from(
    UserFeedback feedback,
    String appVersion,
    String systemVersion,
  ) =>
      UserFeedbackDto(
        type: feedback.type.name.toUpperCase(),
        screen: feedback.screen,
        rating: feedback.rating?.name.toUpperCase(),
        message: feedback.message,
        tags: [],
        appVersion: appVersion,
        systemVersion: systemVersion,
      );

  factory UserFeedbackDto.fromJson(Map<String, dynamic> json) => _$UserFeedbackDtoFromJson(json);

  final String type;
  final String screen;
  final String? rating;
  final String? message;
  final List<String>? tags;
  @JsonKey(name: 'app_version')
  final String? appVersion;
  @JsonKey(name: 'system_version')
  final String? systemVersion;

  Map<String, dynamic> toJson() => _$UserFeedbackDtoToJson(this);

  List<Object?> get props => [type, rating, message, screen, tags, appVersion, systemVersion];
}
