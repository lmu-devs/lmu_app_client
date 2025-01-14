import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@JsonSerializable()
class FeedbackModel {
  final String type;
  final String? rating;
  final String? message;
  final String screen;
  final List<String>? tags;
  @JsonKey(name: 'app_version')
  final String? appVersion;
  @JsonKey(name: 'system_version')
  final String? systemVersion;

  const FeedbackModel({
    required this.type,
    required this.rating,
    required this.message,
    required this.screen,
    required this.tags,
    required this.appVersion,
    required this.systemVersion,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);

  List<Object?> get props => [
        type,
        rating,
        message,
        screen,
        tags,
        appVersion,
        systemVersion,
      ];
}
