import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'link_model.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel extends Equatable {
  @JsonKey(name: 'submissionFee')
  final String submissionFee;
  @JsonKey(name: 'lectureFreeTime')
  final String lectureFreeTime;
  @JsonKey(name: 'lectureTime')
  final String lectureTime;
  final List<LinkModel> links;

  const HomeModel({
    required this.submissionFee,
    required this.lectureFreeTime,
    required this.lectureTime,
    required this.links,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  @override
  List<Object?> get props => [
        submissionFee,
        lectureFreeTime,
        lectureTime,
        links,
      ];
}
