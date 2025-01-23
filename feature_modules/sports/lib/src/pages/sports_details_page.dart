import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/models/sports_model.dart';

class SportsDetailsPage extends StatelessWidget {
  const SportsDetailsPage({super.key, required this.sport});

  final SportsModel sport;

  @override
  Widget build(BuildContext context) {
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
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LmuButton(
                        emphasis: ButtonEmphasis.secondary,
                        title: "Kurs buchen",
                        trailingIcon: LucideIcons.external_link,
                      ),
                    ],
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  LmuListItem.base(
                    leadingArea: Center(child: LmuText.body("🥇")),
                    subtitle: '${sport.courses.length} ${sport.courses.length == 1 ? "Kurs" : "Kurse"}',
                    hasDivider: true,
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                content: sport.courses
                    .map(
                      (course) => LmuListItem.base(
                        title: course.title.isNotEmpty ? course.title : 'Kurs',
                        subtitle:
                            course.price.studentPrice > 0 ? '${course.price.studentPrice.toInt()} €' : 'Basis Ticket',
                        mainContentAlignment: MainContentAlignment.center,
                        leadingArea: LmuStatusDot(
                          statusColor:
                              sport.courses.any((course) => course.isAvailable) ? StatusColor.green : StatusColor.red,
                        ),
                        trailingTitle: course.timeSlots.isNotEmpty
                            ? course.timeSlots.map(
                                (e) {
                                  final day = e.day.localizedWeekdayShort(context.locals.app);
                                  final startTime = e.startTime.substring(0, 5);
                                  final endTime = e.endTime.substring(0, 5);
                                  return '$day, $startTime - $endTime';
                                },
                              ).join(", ")
                            : null,
                        trailingSubtitle: course.location?.address,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
