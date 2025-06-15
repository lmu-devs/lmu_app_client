import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'people_dto.g.dart';

// data transfer object (DTO) für datentransferierung
@JsonSerializable()
class PeopleDto extends Equatable {
  const PeopleDto({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.email,
    required this.office,
    required this.phone,
    required this.faviconUrl,
  });

  final String id;
  final String name;
  final String description;
  final String url;
  final String email;
  final String phone;
  final String office;
  @JsonKey(name: 'favicon_url')
  final String faviconUrl;

  factory PeopleDto.fromJson(Map<String, dynamic> json) => _$PeopleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeopleDtoToJson(this);

  @override
  List<Object?> get props => [id, name, description, url, faviconUrl];
}
