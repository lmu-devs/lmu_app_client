import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../repository/api/models/sports_course.dart';
import '../repository/api/models/sports_time_slot.dart';

class SportsCourseTile extends StatelessWidget {
  const SportsCourseTile({super.key, required this.course, this.hasDivider = false});

  final SportsCourse course;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final sportsLocals = context.locals.sports;
    final subtitleColor = colors.neutralColors.textColors.mediumColors.base;

    final instructor = course.instructor;
    final timeSlots = course.timeSlots;
    final location = course.location;
    return Container(
      margin: EdgeInsets.only(bottom: hasDivider ? LmuSizes.size_12 : LmuSizes.none),
      padding: const EdgeInsets.all(LmuSizes.size_16),
      decoration: BoxDecoration(
        color: colors.neutralColors.backgroundColors.tile,
        borderRadius: BorderRadius.circular(LmuSizes.size_12),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LmuInTextVisual.text(
                    title: course.isAvailable ? sportsLocals.available : sportsLocals.fullyBooked,
                    actionType: course.isAvailable ? ActionType.success : ActionType.destructive,
                  ),
                  const SizedBox(width: LmuSizes.size_8),
                  LmuText.body("${course.price.studentPrice.toInt()} €", color: subtitleColor),
                ],
              ),
              GestureDetector(
                child: const StarIcon(),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.size_8),
          LmuText.body(course.title.isEmpty ? sportsLocals.course : course.title, weight: FontWeight.w600),
          if (timeSlots.isNotEmpty || instructor.isNotEmpty) const SizedBox(height: LmuSizes.size_4),
          if (timeSlots.isNotEmpty) LmuText.body(formatSportsTimeSlots(context, timeSlots), color: subtitleColor),
          if (instructor.isNotEmpty) LmuText.body("${sportsLocals.withTrainer} $instructor", color: subtitleColor),
          if (location != null) const SizedBox(height: LmuSizes.size_8),
          if (location != null) LmuText.body(course.location?.address, color: subtitleColor),
        ],
      ),
    );
  }
}

String formatSportsTimeSlots(BuildContext context, List<SportsTimeSlot> slots) {
  final locals = context.locals.app;
  if (slots.isEmpty) return '';

  final groupedByTime = <String, List<Weekday>>{};

  for (final slot in slots) {
    final timeKey = '${slot.startTime.substring(0, 5)} - ${slot.endTime.substring(0, 5)}';
    groupedByTime.putIfAbsent(timeKey, () => []).add(slot.day);
  }

  String formatWeekdays(List<Weekday> days) {
    days.sort((a, b) => a.index.compareTo(b.index));

    if (days.length == 1) {
      return days.first.localizedWeekday(context.locals.app);
    }

    final List<List<Weekday>> groupedRanges = [];
    List<Weekday> currentGroup = [days.first];

    for (int i = 1; i < days.length; i++) {
      if (days[i].index == days[i - 1].index + 1) {
        currentGroup.add(days[i]);
      } else {
        groupedRanges.add(currentGroup);
        currentGroup = [days[i]];
      }
    }
    groupedRanges.add(currentGroup);

    return groupedRanges
        .map((group) => group.length > 1
            ? '${group.first.localizedWeekday(locals)} - ${group.last.localizedWeekday(locals)}' // "Wednesday - Friday"
            : group.first.localizedWeekday(locals))
        .join(', ');
  }

  final formattedStrings = groupedByTime.entries.map((entry) {
    final daysFormatted = formatWeekdays(entry.value);
    return '$daysFormatted, ${entry.key}';
  }).toList();

  return formattedStrings.join('\n');
}
