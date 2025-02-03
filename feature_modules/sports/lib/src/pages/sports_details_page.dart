import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../extensions/date_time_extension.dart';
import '../repository/api/models/sports_course.dart';
import '../repository/api/models/sports_model.dart';
import '../widgets/sports_course_tile.dart';

class SportsDetailsPage extends StatelessWidget {
  const SportsDetailsPage({super.key, required this.sport});

  final SportsModel sport;

  Map<({DateTime startDate, DateTime endDate}), List<SportsCourse>> get _groupedSports {
    final grouped = groupBy(sport.courses, (SportsCourse course) {
      return (startDate: DateTime.parse(course.startDate), endDate: DateTime.parse(course.endDate));
    });

    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.startDate.compareTo(a.key.startDate)),
    );
  }

  String _categoryTitle(SportsLocatizations locals, DateTime startDate, DateTime endDate) {
    final currentDate = DateTime.now();
    if (currentDate.isBefore(startDate)) {
      return locals.upcoming;
    } else if (currentDate.isAfter(endDate)) {
      return locals.past;
    } else {
      return locals.ongoing;
    }
  }

  String _convertTitleToUrl(String title) {
    const replacements = {
      "ä": "ae",
      "ü": "ue",
      "ö": "oe",
      "®": "_",
      "&": "_und_",
      "(": "_",
      ")": "_",
      "/": "_",
      "ß": "ss"
    };

    String parsedTitle = title.replaceAllMapped(
      RegExp(replacements.keys.map(RegExp.escape).join("|")),
      (match) => replacements[match.group(0)]!,
    );

    return parsedTitle.replaceAll(" ", "_");
  }

  @override
  Widget build(BuildContext context) {
    final sportsLocals = context.locals.sports;
    return LmuMasterAppBar(
      largeTitle: sport.title,
      leadingAction: LeadingAction.back,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LmuButton(
                        emphasis: ButtonEmphasis.secondary,
                        title: sportsLocals.bookCourse,
                        trailingIcon: LucideIcons.external_link,
                        onTap: () {
                          LmuUrlLauncher.launchWebsite(
                            url:
                                "https://www.buchung.zhs-muenchen.de/angebote/aktueller_zeitraum_0/_${_convertTitleToUrl(sport.title)}.html",
                            context: context,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  LmuListItem.base(
                    leadingArea: const LmuText("🥇"),
                    hasHorizontalPadding: false,
                    subtitle:
                        '${sport.courses.length} ${sport.courses.length == 1 ? sportsLocals.course : sportsLocals.courses}',
                    hasDivider: true,
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              ..._groupedSports.entries.map(
                (entry) {
                  final startDate = entry.key.startDate;
                  final endDate = entry.key.endDate;
                  final courses = entry.value;

                  final formattedStartDate = startDate.formattedDate;
                  final formattedEndDate = endDate.formattedDate;

                  final startIsEndDate = formattedStartDate == formattedEndDate;

                  return Column(
                    children: [
                      LmuTileHeadline.base(
                        title: _categoryTitle(sportsLocals, startDate, endDate),
                        trailingTitle: startIsEndDate
                            ? formattedStartDate
                            : "${startDate.formattedDate} - ${endDate.formattedDate}",
                      ),
                      ...courses
                          .mapIndexed(
                            (index, course) => SportsCourseTile(
                              course: course,
                              hasDivider: index != courses.length - 1,
                            ),
                          )
                          .toList(),
                      const SizedBox(height: LmuSizes.size_32),
                    ],
                  );
                },
              ),
              const SizedBox(height: LmuSizes.size_64),
            ],
          ),
        ),
      ),
    );
  }
}
