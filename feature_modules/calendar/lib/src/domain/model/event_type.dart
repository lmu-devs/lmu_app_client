import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_type.g.dart';

@JsonEnum(alwaysCreate: true)
enum EventType {
  @JsonValue('MOVIE')
  movie,
  @JsonValue('SPORT')
  sport,
  @JsonValue('LECTURE')
  lecture,
  @JsonValue('EXAM')
  exam,
}

extension EventTypeExtension on EventType {
  String get name => _$EventTypeEnumMap[this]!;

  Color get defaultColor {
    switch (this) {
      case EventType.movie:
        return Colors.blue;
      case EventType.sport:
        return Colors.green;
      case EventType.lecture:
        return Colors.red;
      case EventType.exam:
        return Colors.purple;
    }
  }
}
