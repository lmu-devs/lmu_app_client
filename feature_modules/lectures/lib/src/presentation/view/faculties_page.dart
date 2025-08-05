import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/lectures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

class FacultiesPage extends StatefulWidget {
  const FacultiesPage({super.key});

  @override
  State<FacultiesPage> createState() => _FacultiesPageState();
}

class _FacultiesPageState extends State<FacultiesPage> {
  late final FacultiesApi _facultiesApi;

  @override
  void initState() {
    super.initState();
    _facultiesApi = GetIt.I.get<FacultiesApi>();
  }

  @override
  Widget build(BuildContext context) {
    final lecturesLocalizations = context.locals.lectures;
    final studiesLocalizations = context.locals.studies;
    final appLocalizations = context.locals.app;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: studiesLocalizations.facultiesTitle,
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
            LmuTileHeadline.base(title: '${appLocalizations.all} ${studiesLocalizations.facultiesTitle}'),
            const SizedBox(height: LmuSizes.size_2),

            // Faculty list
            LmuContentTile(
              contentList: _facultiesApi.allFaculties.mapIndexed((index, faculty) {
                return LmuListItem.action(
                  key: Key("faculty_${faculty.id}"),
                  title: faculty.name,
                  leadingArea: LmuInListBlurEmoji(emoji: faculty.id.toString()),
                  trailingTitle: '', // TODO: implement course count
                  actionType: LmuListItemAction.chevron,
                  hasDivider: false,
                  onTap: () {
                    LectureListRoute(facultyId: faculty.id).go(context);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
