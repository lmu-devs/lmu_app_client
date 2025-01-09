import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@JsonSerializable()
class FeedbackModel extends Equatable {
  final String type;
  final String? rating;
  final String? message;
  final String screen;
  final List<String>? tags;

  const FeedbackModel({
    required this.type,
    required this.rating,
    required this.message,
    required this.screen,
    required this.tags,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);

  @override
  List<Object?> get props => [
        type,
        rating,
        message,
        screen,
        tags,
      ];
}
