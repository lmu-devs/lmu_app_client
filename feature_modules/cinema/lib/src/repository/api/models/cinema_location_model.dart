import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cinema_location_model.g.dart';

@JsonSerializable()
class CinemaLocationModel extends Equatable {
  const CinemaLocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String address;
  final double? latitude;
  final double? longitude;

  @override
  List<Object> get props => [
    address,
    latitude ?? 0,
    longitude ?? 0,
  ];

  factory CinemaLocationModel.fromJson(Map<String, dynamic> json) => _$CinemaLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaLocationModelToJson(this);
}