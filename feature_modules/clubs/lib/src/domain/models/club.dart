import 'package:core/api.dart';
import 'package:equatable/equatable.dart';

import 'club_type.dart';

class Club extends Equatable {
  const Club({
    required this.id,
    this.universityId,
    required this.type,
    required this.title,
    required this.description,
    this.isFeatured = false,
    this.image,
    this.content,
    this.url,
    this.email,
    this.instagramUrl,
    this.linkedinUrl,
    this.foundingYear,
    this.location,
  });

  final String id;
  final String? universityId;
  final ClubType type;
  final String title;
  final String description;
  final bool isFeatured;
  final ImageModel? image;
  final String? content;
  final String? url;
  final String? email;
  final String? instagramUrl;
  final String? linkedinUrl;
  final int? foundingYear;
  final LocationModel? location;

  @override
  List<Object?> get props => [
        id,
        universityId,
        type,
        title,
        description,
        isFeatured,
        image,
        content,
        url,
        email,
        instagramUrl,
        linkedinUrl,
        foundingYear,
        location,
      ];

  @override
  bool? get stringify => true;
}
