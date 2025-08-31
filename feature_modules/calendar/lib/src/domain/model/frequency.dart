import 'package:json_annotation/json_annotation.dart';

part 'frequency.g.dart';

@JsonEnum(alwaysCreate: true)
enum Frequency {
  @JsonValue('ONCE')
  once,
  @JsonValue('DAILY')
  daily,
  @JsonValue('WEEKLY')
  weekly,
  @JsonValue('MONTHLY')
  monthly,
  @JsonValue('YEARLY')
  yearly,
}

extension FrequencyExtension on Frequency {
  String get name => _$FrequencyEnumMap[this]!;
}
