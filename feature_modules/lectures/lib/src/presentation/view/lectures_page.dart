import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';

import 'lecture_list_page.dart';

class LecturesPage extends StatelessWidget {
  const LecturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: 'Fakultäten',
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
            // Header row: title + search/sort
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LmuTileHeadline.base(title: 'Alle Fakultäten'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: 'Suche',
                      onPressed: () {
                        // TODO: implement search
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.sort),
                      tooltip: 'Sortieren',
                      onPressed: () {
                        // TODO: implement sort
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_8),

            // Faculty list
            LmuContentTile(
              contentList: _faculties.mapIndexed((index, faculty) {
                return LmuListItem.action(
                  key: Key("faculty_${faculty['id']}"),
                  title: faculty['name'] as String,
                  leadingArea: _FacultyIdBadge(id: faculty['id'] as String),
                  trailingTitle: (faculty['courseCount'] as int).toString(),
                  actionType: LmuListItemAction.chevron,
                  hasDivider: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LectureListPage(
                          facultyId: faculty['id'] as String,
                          facultyName: faculty['name'] as String,
                        ),
                      ),
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

class _FacultyIdBadge extends StatelessWidget {
  final String id;

  const _FacultyIdBadge({required this.id});

  @override
  Widget build(BuildContext context) {
    return LmuInListBlurEmoji(
      emoji: id,
    );
  }
}
