import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel extends Equatable {
  const ImageModel({required this.url, required this.name, required this.blurHash});

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);

  final String url;
  final String? name;
  final String? blurHash;

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  @override
  List<Object?> get props => [url, name, blurHash];
}
