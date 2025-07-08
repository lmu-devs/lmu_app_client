import '../../../../domain/model/calendar_entry.dart';
import 'calendar_entry_dto.dart';
import 'calendar_rule_dto.dart';

class CalendarEntryMapper {
  static CalendarEntry fromDto(CalendarEntryDto dto) {
    return CalendarEntry(
      id: dto.id,
      title: dto.title,
      type: dto.type,
      startDate: dto.startDate,
      endDate: dto.endDate,
      color: dto.color,
      location: dto.location,
      allDay: dto.allDay,
      description: dto.description,
      address: dto.address,
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
      type: domain.type,
      startDate: domain.startDate,
      endDate: domain.endDate,
      color: domain.color,
      location: domain.location,
      allDay: domain.allDay,
      description: domain.description,
      address: domain.address,
      rule: domain.rule != null ? CalendarRuleDto.fromDomain(domain.rule!) : null,
      recurrenceId: domain.recurrenceId,
      createdAt: domain.createdAt,
      updatedAt: domain.updatedAt,
    );
  }
}
