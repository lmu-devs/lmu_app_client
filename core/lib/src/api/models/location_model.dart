import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends Equatable {
  const LocationModel({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  final String address;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [
        address,
        latitude,
        longitude,
      ];

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  /// Checks if the location is an online location based on the address.
  /// An online location is identified by a URL pattern.
  bool get isOnline {
    final RegExp urlRegex = RegExp(
      r'((https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})(\/\S*)?',
      caseSensitive: false,
    );
    return urlRegex.hasMatch(address);
  }
}
