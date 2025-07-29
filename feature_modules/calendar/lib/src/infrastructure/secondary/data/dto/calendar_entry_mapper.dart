import '../../../../domain/model/calendar_entry.dart';
import 'calendar_entry_dto.dart';
import 'calendar_rule_dto.dart';

class CalendarEntryMapper {
  static CalendarEntry fromDto(CalendarEntryDto dto) {
    return CalendarEntry(
      id: dto.id,
      title: dto.title,
      eventType: dto.eventType,
      startTime: dto.startTime,
      endTime: dto.endTime,
      color: dto.color,
      location: dto.location,
      allDay: dto.allDay,
      description: dto.description,
      rule: dto.rule?.toDomain(),
      recurrenceId: dto.recurrenceId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static CalendarEntryDto toDto(CalendarEntry domain) {
    return CalendarEntryDto(
      id: domain.id,
      title: domain.title,
      eventType: domain.eventType,
      startTime: domain.startTime,
      endTime: domain.endTime,
      color: domain.color,
      location: domain.location,
      allDay: domain.allDay,
      description: domain.description,
      rule: domain.rule != null ? CalendarRuleDto.fromDomain(domain.rule!) : null,
      recurrenceId: domain.recurrenceId,
      createdAt: domain.createdAt,
      updatedAt: domain.updatedAt,
    );
  }
}
