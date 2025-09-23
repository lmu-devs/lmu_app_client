import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/lecture.dart';

part 'lecture_dto.g.dart';

@JsonSerializable()
class LectureDto extends Equatable {
  const LectureDto({
    this.id,
    this.name,
    this.facultyId,
    this.description,
    this.sws,
    this.semester,
    this.tags = const [],
  });

  factory LectureDto.fromJsonWithTags(Map<String, dynamic> json) {
    return LectureDto(
      id: json['publish_id']?.toString(),
      name: json['name']?.toString(),
      facultyId: null,
      description: json['description']?.toString(),
      sws: _parseIntSafely(json['sws']),
      semester: json['semester']?.toString(),
      tags: _extractTags(json),
    );
  }

  factory LectureDto.fromJson(Map<String, dynamic> json) {
    try {
      // Use the custom method that handles tags properly
      return LectureDto.fromJsonWithTags(json);
    } catch (e) {
      // Handle potential parsing errors gracefully
      return LectureDto(
        id: _extractId(json),
        name: _extractName(json),
        facultyId: null, // Faculty ID comes from context, not API
        description: _extractDescription(json),
        sws: _extractSws(json),
        semester: _extractSemester(json),
        tags: _extractTags(json),
      );
    }
  }

  static String? _extractId(Map<String, dynamic> json) {
    // Try different possible ID field names
    return json['publish_id']?.toString() ??
        json['id']?.toString() ??
        json['publishId']?.toString() ??
        json['course_id']?.toString() ??
        json['courseId']?.toString();
  }

  static String? _extractName(Map<String, dynamic> json) {
    // Try different possible name field names
    return json['name']?.toString() ??
        json['title']?.toString() ??
        json['course_name']?.toString() ??
        json['courseName']?.toString();
  }

  static String? _extractDescription(Map<String, dynamic> json) {
    return json['description']?.toString() ?? json['desc']?.toString() ?? json['summary']?.toString();
  }

  static int? _extractSws(Map<String, dynamic> json) {
    final sws = _parseIntSafely(json['sws']);
    if (sws > 0) return sws;

    // Fallback to credits field for backward compatibility
    final credits = _parseIntSafely(json['credits']);
    if (credits > 0) return credits;

    final creditPoints = _parseIntSafely(json['credit_points']);
    if (creditPoints > 0) return creditPoints;

    final creditPointsCamel = _parseIntSafely(json['creditPoints']);
    if (creditPointsCamel > 0) return creditPointsCamel;

    return null;
  }

  static String? _extractSemester(Map<String, dynamic> json) {
    return json['semester']?.toString() ?? json['term']?.toString() ?? json['period']?.toString();
  }

  static List<String> _extractTags(Map<String, dynamic> json) {
    // Extract from available fields like class_type, language, etc.
    final tags = <String>[];

    if (json['class_type']?.toString().isNotEmpty == true) {
      tags.add(json['class_type'].toString());
    }
    if (json['language']?.toString().isNotEmpty == true) {
      tags.add(json['language'].toString());
    }

    // Add SWS to tags if available
    final swsValue = _parseIntSafely(json['sws']);
    if (swsValue > 0) {
      tags.add('${swsValue}SWS');
    }

    if (tags.isNotEmpty) return tags;

    final jsonTags = _parseStringListSafely(json['tags']);
    if (jsonTags.isNotEmpty) return jsonTags;

    final categories = _parseStringListSafely(json['categories']);
    if (categories.isNotEmpty) return categories;

    final keywords = _parseStringListSafely(json['keywords']);
    if (keywords.isNotEmpty) return keywords;

    return const [];
  }

  static int _parseIntSafely(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static List<String> _parseStringListSafely(dynamic value) {
    if (value == null) return const [];
    if (value is List) {
      return value.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList();
    }
    return const [];
  }

  @JsonKey(name: 'publish_id', fromJson: _intToString, toJson: _stringToInt)
  final String? id;

  @JsonKey(name: 'name', fromJson: _stringFromJson, toJson: _stringToJson)
  final String? name;

  final int? facultyId;

  @JsonKey(name: 'description', fromJson: _stringFromJson, toJson: _stringToJson)
  final String? description;

  @JsonKey(name: 'sws', fromJson: _intFromJson, toJson: _intToJson)
  final int? sws;

  @JsonKey(name: 'semester', fromJson: _stringFromJson, toJson: _stringToJson)
  final String? semester;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<String> tags;

  static String? _stringFromJson(dynamic value) => value?.toString();
  static dynamic _stringToJson(String? value) => value;

  static int? _intFromJson(dynamic value) => _parseIntSafely(value);
  static dynamic _intToJson(int? value) => value;

  static String? _intToString(dynamic value) => value?.toString();
  static dynamic _stringToInt(String? value) => value != null ? int.tryParse(value) : null;

  Lecture toDomain({required int facultyId, int termId = 1, int year = 2025}) => Lecture(
        id: id?.isNotEmpty == true ? id! : 'unknown',
        title: name?.isNotEmpty == true ? name! : 'Untitled Lecture',
        description: description?.isNotEmpty == true ? description : null,
        sws: sws,
        semester: _formatSemester(termId, year),
        facultyId: facultyId,
        tags: tags.where((tag) => tag.isNotEmpty).toList(),
      );

  static String? _formatSemester(int termId, int year) {
    // termId: 1 = Winter semester, 2 = Summer semester
    final semester = termId == 1 ? 'WS' : 'SS';
    final yearShort = year.toString().substring(2); // Convert 2025 to 25
    return '$semester$yearShort';
  }

  Map<String, dynamic> toJson() => _$LectureDtoToJson(this);

  @override
  List<Object?> get props => [id, name, facultyId, description, sws, semester, tags];
}
