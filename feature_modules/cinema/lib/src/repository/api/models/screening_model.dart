import 'university_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cinema_model.dart';
import 'cinema_location_model.dart';
import 'movie_model.dart';

part 'screening_model.g.dart';

@JsonSerializable()
class ScreeningModel extends Equatable {
  const ScreeningModel({
    required this.id,
    required this.entryTime,
    required this.startTime,
    required this.endTime,
    required this.price,
    this.isOv,
    this.subtitles,
    this.externalLink,
    required this.note,
    required this.movie,
    required this.location,
    required this.university,
    required this.cinema,
  });

  final String id;
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
  final CinemaLocationModel location;
  final UniversityModel university;
  final CinemaModel cinema;

  @override
  List<Object?> get props => [
    id,
    entryTime,
    startTime,
    endTime,
    price,
    isOv,
    subtitles,
    externalLink,
    note,
    movie,
    location,
    university,
    cinema,
  ];

  factory ScreeningModel.fromJson(Map<String, dynamic> json) => _$ScreeningModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScreeningModelToJson(this);
}