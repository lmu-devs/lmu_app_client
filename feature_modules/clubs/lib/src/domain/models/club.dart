import 'package:equatable/equatable.dart';

import 'club_category_type.dart';
import 'club_type.dart';

class Club extends Equatable {
  const Club({
    required this.id,
    this.universityId,
    required this.type,
    required this.title,
    required this.description,
    required this.category,
    this.isFeatured = false,
    this.logoUrl,
    this.content,
    this.url,
    this.email,
    this.instagramUrl,
    this.linkedinUrl,
  });

  final String id;
  final String? universityId;
  final ClubType type;
  final String title;
  final String description;
  final ClubCategoryType category;
  final bool isFeatured;
  final String? logoUrl;
  final String? content;
  final String? url;
  final String? email;
  final String? instagramUrl;
  final String? linkedinUrl;

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
