import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/model/calendar_rule.dart';
import '../../../../domain/model/frequency.dart';

part 'calendar_rule_dto.g.dart';

@JsonSerializable()
class CalendarRuleDto {
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

  factory CalendarRuleDto.fromJson(Map<String, dynamic> json) => _$CalendarRuleDtoFromJson(json);

  final Frequency frequency;
  final int interval;
  @JsonKey(name: 'until_time')
  final DateTime? untilTime;

  CalendarRule toDomain() {
    return CalendarRule(
      frequency: frequency,
      interval: interval,
      untilTime: untilTime,
    );
  }

  Map<String, dynamic> toJson() => _$CalendarRuleDtoToJson(this);
}
