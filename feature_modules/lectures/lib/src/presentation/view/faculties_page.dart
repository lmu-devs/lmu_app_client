import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';

class FacultiesPage extends StatelessWidget {
  const FacultiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lecturesLocalizations = context.locals.lectures;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: lecturesLocalizations.facultiesTitle,
        leadingAction: LeadingAction.back,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          LmuSizes.size_16,
          LmuSizes.size_16,
          LmuSizes.size_16,
          LmuSizes.size_96,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Action buttons row
            LmuButtonRow(
              hasHorizontalPadding: false,
              buttons: [
                LmuIconButton(
                  icon: LucideIcons.search,
                  onPressed: () {
                    // TODO: implement search
                  },
                ),
                LmuIconButton(
                  icon: LucideIcons.arrow_up_down,
                  onPressed: () {
                    // TODO: implement sort
                  },
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_32),

            // Header row: title
            LmuTileHeadline.base(title: lecturesLocalizations.allFacultiesTitle),
            const SizedBox(height: LmuSizes.size_2),

            // Faculty list
            LmuContentTile(
              contentList: _faculties.mapIndexed((index, faculty) {
                return LmuListItem.action(
                  key: Key("faculty_${faculty['id']}"),
                  title: faculty['name'] as String,
                  leadingArea: LmuInListBlurEmoji(emoji: faculty['id'] as String),
                  trailingTitle: (faculty['courseCount'] as int).toString(),
                  actionType: LmuListItemAction.chevron,
                  hasDivider: false,
                  onTap: () {
                    context.push(
                      '/lecture-list',
                      extra: {
                        'facultyId': faculty['id'] as String,
                        'facultyName': faculty['name'] as String,
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  static final _faculties = [
    {'id': '00', 'name': 'Fakultätsübergreifende Veranstaltung', 'courseCount': 26},
    {'id': '01', 'name': 'Katholisch-Theologische Fakultät', 'courseCount': 120},
    {'id': '02', 'name': 'Evangelisch - Theologische Fakultät', 'courseCount': 143},
    {'id': '03', 'name': 'Juristische Fakultät', 'courseCount': 210},
    {'id': '04', 'name': 'Fakultät für Betriebswirtschaft', 'courseCount': 324},
    {'id': '05', 'name': 'Volkswirtschaftliche Fakultät', 'courseCount': 289},
    {'id': '07', 'name': 'Medizinische Fakultät', 'courseCount': 196},
    {'id': '08', 'name': 'Tierärztliche Fakultät', 'courseCount': 167},
    {'id': '09', 'name': 'Fakultät für Geschichts- und Kunstwissenschaften', 'courseCount': 112},
    {
      'id': '10',
      'name': 'Fakultät für Philosophie, Wissenschaftstheorie und Religionswissenschaft',
      'courseCount': 123,
    },
    {'id': '11', 'name': 'Fakultät für Psychologie und Pädagogik', 'courseCount': 145},
    {'id': '12', 'name': 'Fakultät für Kulturwissenschaften', 'courseCount': 165},
    {'id': '13', 'name': 'Fakultät für Sprach- und Literaturwissenschaften', 'courseCount': 112},
    {'id': '15', 'name': 'Sozialwissenschaftliche Fakultät', 'courseCount': 97},
    {'id': '16', 'name': 'Fakultät für Mathematik, Informatik und Statistik', 'courseCount': 320},
    {'id': '17', 'name': 'Fakultät für Physik', 'courseCount': 112},
    {'id': '18', 'name': 'Fakultät für Chemie und Pharmazie', 'courseCount': 112},
    {'id': '19', 'name': 'Fakultät für Biologie', 'courseCount': 112},
    {'id': '20', 'name': 'Fakultät für Geowissenschaften', 'courseCount': 112},
  ];
}
