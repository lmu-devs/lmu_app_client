import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/club_category_type.dart';
import '../../../../domain/models/club_type.dart';

part 'club_dto.g.dart';

@JsonSerializable()
class ClubDto extends Equatable {
  const ClubDto({
    required this.id,
    this.universityId,
    required this.type,
    required this.title,
    required this.description,
    required this.category,
    this.logoUrl,
    this.content,
    this.url,
    this.email,
    this.instagramUrl,
    this.linkedinUrl,
  });

  factory ClubDto.fromJson(Map<String, dynamic> json) => _$ClubDtoFromJson(json);

  final String id;
  @JsonKey(name: 'university_id')
  final String? universityId;
  final ClubType type;
  final String title;
  final String description;
  final ClubCategoryType category;
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  final String? content;
  final String? url;
  final String? email;
  @JsonKey(name: 'instagram_url')
  final String? instagramUrl;
  @JsonKey(name: 'linkedin_url')
  final String? linkedinUrl;

  Map<String, dynamic> toJson() => _$ClubDtoToJson(this);

  @override
  List<Object?> get props =>
      [id, universityId, type, title, description, category, logoUrl, content, url, email, instagramUrl, linkedinUrl];
}
