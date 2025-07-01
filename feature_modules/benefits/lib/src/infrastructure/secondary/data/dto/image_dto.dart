import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_dto.g.dart';

@JsonSerializable()
class ImageDto extends Equatable {
  const ImageDto({
    required this.url,
    required this.title,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) => _$ImageDtoFromJson(json);

  final String url;
  final String title;

  Map<String, dynamic> toJson() => _$ImageDtoToJson(this);

  @override
  List<Object?> get props => [url, title];
}
