// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_rule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarRuleDto _$CalendarRuleDtoFromJson(Map<String, dynamic> json) =>
    CalendarRuleDto(
      frequency: $enumDecode(_$FrequencyEnumMap, json['frequency']),
      interval: (json['interval'] as num).toInt(),
      untilTime: json['until_time'] == null
          ? null
          : DateTime.parse(json['until_time'] as String),
    );

Map<String, dynamic> _$CalendarRuleDtoToJson(CalendarRuleDto instance) =>
    <String, dynamic>{
      'frequency': _$FrequencyEnumMap[instance.frequency]!,
      'interval': instance.interval,
      'until_time': instance.untilTime?.toIso8601String(),
    };

const _$FrequencyEnumMap = {
  Frequency.once: 'ONCE',
  Frequency.daily: 'DAILY',
  Frequency.weekly: 'WEEKLY',
  Frequency.monthly: 'MONTHLY',
  Frequency.yearly: 'YEARLY',
};
