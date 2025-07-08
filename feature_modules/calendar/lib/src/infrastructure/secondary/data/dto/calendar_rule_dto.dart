import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/calendar_rule.dart';
import '../../../../domain/model/frequency.dart';

part 'calendar_rule_dto.g.dart';

@JsonSerializable()
class CalendarRuleDto {
  // Method to convert domain model to DTO for serialization to JSON
  factory CalendarRuleDto.fromDomain(CalendarRule domain) {
    return CalendarRuleDto(
      frequency: domain.frequency,
      interval: domain.interval,
      untilTime: domain.untilTime,
    );
  }
  CalendarRuleDto({
    required this.frequency,
    required this.interval,
    this.untilTime,
  });

  // Factory constructor for deserialization from JSON
  factory CalendarRuleDto.fromJson(Map<String, dynamic> json) => _$CalendarRuleDtoFromJson(json);

  final Frequency frequency;
  final int interval;
  @JsonKey(name: 'until_time') // JsonKey annotation for API compatibility
  final DateTime? untilTime;

  // Method to convert DTO to domain model
  CalendarRule toDomain() {
    return CalendarRule(
      frequency: frequency,
      interval: interval,
      untilTime: untilTime,
    );
  }

  // Method for serialization to JSON
  Map<String, dynamic> toJson() => _$CalendarRuleDtoToJson(this);
}
