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

  factory LectureDto.fromJson(Map<String, dynamic> json) {
    // Use the generated method for standard fields
    final dto = _$LectureDtoFromJson(json);
    // Extract tags separately as they're not in the standard JSON
    return LectureDto(
      id: dto.id,
      name: dto.name,
      facultyId: dto.facultyId,
      description: dto.description,
      sws: dto.sws,
      semester: dto.semester,
      tags: _extractTags(json),
    );
  }

  static List<String> _extractTags(Map<String, dynamic> json) {
    final tags = <String>[];

    // Extract from common fields
    _addIfNotEmpty(tags, json['class_type']);
    _addIfNotEmpty(tags, json['language']);
    _addIfNotEmpty(tags, json['type']);

    // Add SWS to tags if available
    final swsValue = _parseIntSafely(json['sws']);
    if (swsValue > 0) {
      tags.add('${swsValue}SWS');
    }

    // Add from array fields
    tags.addAll(_parseStringListSafely(json['tags']));
    tags.addAll(_parseStringListSafely(json['categories']));
    tags.addAll(_parseStringListSafely(json['keywords']));

    return tags;
  }

  static void _addIfNotEmpty(List<String> list, dynamic value) {
    final stringValue = value?.toString();
    if (stringValue != null && stringValue.isNotEmpty) {
      list.add(stringValue);
    }
  }

  static int _parseIntSafely(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static List<String> _parseStringListSafely(dynamic value) {
    if (value is! List) return const [];
    return value.map((e) => e?.toString()).where((e) => e?.isNotEmpty == true).cast<String>().toList();
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

  Lecture toDomain({required int facultyId, required int termId, required int year}) => Lecture(
        id: id?.isNotEmpty == true ? id! : 'unknown',
        title: name?.isNotEmpty == true ? name! : 'Untitled Lecture',
        description: description?.isNotEmpty == true ? description : null,
        sws: sws,
        semester: _formatSemester(termId, year),
        facultyId: facultyId,
        tags: tags.where((tag) => tag.isNotEmpty).toList(),
      );

  static String _formatSemester(int termId, int year) {
    // termId: 1 = Winter semester, 2 = Summer semester
    final semester = termId == 1 ? 'WS' : 'SS';
    final yearShort = year.toString().substring(2); // Convert 2025 to 25
    return '$semester$yearShort';
  }

  Map<String, dynamic> toJson() => _$LectureDtoToJson(this);

  @override
  List<Object?> get props => [id, name, facultyId, description, sws, semester, tags];
}
