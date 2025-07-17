import 'dart:ui';

import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/sports_course.dart';
import '../repository/api/models/sports_time_slot.dart';
import '../services/sports_state_service.dart';

class SportsCourseTile extends StatelessWidget {
  const SportsCourseTile({
    super.key,
    required this.course,
    required this.sportType,
    this.hasDivider = false,
  });

  final SportsCourse course;
  final String sportType;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    final sportsStateService = GetIt.I.get<SportsStateService>();
    final colors = context.colors;
    final locals = context.locals;
    final appLocals = locals.app;
    final sportsLocals = locals.sports;
    final subtitleColor = colors.neutralColors.textColors.mediumColors.base;
    final isCourseInPast = DateTime.parse(course.endDate).isBefore(DateTime.now());

    final instructor = course.instructor;
    final timeSlots = course.timeSlots;
    final location = course.location;

    final price = course.price.studentPrice.toInt();

    return GestureDetector(
      onTap: () {
        final url = GetIt.I.get<SportsStateService>().constructUrl(sportType);
        LmuUrlLauncher.launchWebsite(context: context, url: url);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: hasDivider ? LmuSizes.size_12 : LmuSizes.none),
        decoration: BoxDecoration(
          color: colors.neutralColors.backgroundColors.tile,
          borderRadius: BorderRadius.circular(LmuSizes.size_12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(LmuSizes.size_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: LmuInTextVisual.text(
                      title: isCourseInPast
                          ? sportsLocals.past
                          : course.isAvailable
                              ? appLocals.available
                              : sportsLocals.fullyBooked,
                      actionType: isCourseInPast
                          ? ActionType.base
                          : course.isAvailable
                              ? ActionType.success
                              : ActionType.destructive,
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_8),
                  LmuText.body(course.title.isEmpty ? sportsLocals.course : course.title, weight: FontWeight.w600),
                  if (timeSlots.isNotEmpty || instructor.isNotEmpty) const SizedBox(height: LmuSizes.size_4),
                  if (timeSlots.isNotEmpty)
                    LmuText.body(formatSportsTimeSlots(appLocals, timeSlots), color: subtitleColor),
                  if (instructor.isNotEmpty) LmuText.body("${appLocals.withPerson} $instructor", color: subtitleColor),
                  if (location != null)
                    LmuText.body("${appLocals.atLocation} ${location.address}", color: subtitleColor),
                  const SizedBox(height: LmuSizes.size_8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(_ticketAsset, package: "sports"),
                      const SizedBox(width: LmuSizes.size_8),
                      if (price > 0) LmuText.body("+ $price €", color: subtitleColor),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: LmuSizes.size_6,
              top: LmuSizes.size_8,
              child: ValueListenableBuilder(
                valueListenable: sportsStateService.favoriteSportsCoursesNotifier,
                builder: (context, favoriteSports, _) {
                  final isFavorite = favoriteSports.any(
                    (entry) => entry.category == sportType && entry.favorites.contains(course.id),
                  );

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      LmuVibrations.secondary();
                      sportsStateService.toggleFavoriteSport(course.id, sportType);
                      if (isFavorite) {
                        LmuToast.show(
                          context: context,
                          type: ToastType.success,
                          message: appLocals.favoriteRemoved,
                          actionText: appLocals.undo,
                          onActionPressed: () {
                            sportsStateService.toggleFavoriteSport(course.id, sportType);
                          },
                        );
                      } else {
                        LmuToast.show(
                          context: context,
                          type: ToastType.success,
                          message: appLocals.favoriteAdded,
                        );
                      }
                    },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: StarIcon(isActive: isFavorite),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _ticketAsset => PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? 'assets/basisticket_light.svg'
      : 'assets/basisticket_dark.svg';
}

String formatSportsTimeSlots(AppLocalizations locals, List<SportsTimeSlot> slots) {
  if (slots.isEmpty) return '';

  final groupedByTime = <String, List<Weekday>>{};

  for (final slot in slots) {
    final timeKey = '${slot.startTime.substring(0, 5)} - ${slot.endTime.substring(0, 5)}';
    groupedByTime.putIfAbsent(timeKey, () => []).add(slot.day);
  }

  String formatWeekdays(List<Weekday> days) {
    days.sort((a, b) => a.index.compareTo(b.index));

    if (days.length == 1) {
      return days.first.name;
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
        .map((group) => group.length > 1 ? '${group.first.name} - ${group.last.name}' : group.first.name)
        .join(', ');
  }

  final formattedStrings = groupedByTime.entries.map((entry) {
    final daysFormatted = formatWeekdays(entry.value);
    return '$daysFormatted, ${entry.key}';
  }).toList();

  return formattedStrings.join('\n');
}
