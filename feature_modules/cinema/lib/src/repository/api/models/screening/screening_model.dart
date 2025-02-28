import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../movie/movie_model.dart';

part 'screening_model.g.dart';

@JsonSerializable()
class ScreeningModel extends Equatable {
  const ScreeningModel({
    required this.id,
    required this.cinemaId,
    required this.universityId,
    required this.entryTime,
    required this.startTime,
    required this.endTime,
    required this.price,
    this.isOv,
    this.subtitles,
    this.externalLink,
    required this.note,
    required this.movie,
  });

  final String id;
  @JsonKey(name: 'cinema_id')
  final String cinemaId;
  @JsonKey(name: 'university_id')
  final String universityId;
  @JsonKey(name: 'entry_time')
  final String entryTime;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  final double price;
  @JsonKey(name: 'is_ov')
  final bool? isOv;
  final String? subtitles;
  @JsonKey(name: 'external_link')
  final String? externalLink;
  final String? note;
  final MovieModel movie;

  @override
  List<Object?> get props => [
        id,
        cinemaId,
        universityId,
        entryTime,
        startTime,
        endTime,
        price,
        isOv,
        subtitles,
        externalLink,
        note,
        movie,
      ];

  factory ScreeningModel.fromJson(Map<String, dynamic> json) => _$ScreeningModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScreeningModelToJson(this);
}
