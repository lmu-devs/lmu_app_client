import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/home.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

class LinksFacultiesPage extends StatelessWidget {
  const LinksFacultiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: LmuPageAnimationWrapper(
        child: Align(
          alignment: Alignment.topCenter,
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final facultiesApi = GetIt.I.get<FacultiesApi>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: LmuSizes.size_16),
        if (facultiesApi.selectedFaculties.isNotEmpty) ...[
          LmuTileHeadline.base(title: context.locals.studies.myFaculties),
          LmuContentTile(
            contentList: facultiesApi.selectedFaculties
                .map(
                  (faculty) => LmuListItem.action(
                    leadingArea: FacultyNumberWidget(facultyId: faculty.id),
                    actionType: LmuListItemAction.chevron,
                    title: faculty.name,
                    onTap: () => LinksOverviewRoute(facultyId: faculty.id).push(context),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: LmuSizes.size_24),
        ],
        LmuTileHeadline.base(title: context.locals.studies.allFaculties),
        const SizedBox(height: LmuSizes.size_2),
        LmuContentTile(
          contentList: facultiesApi.allFaculties
              .map(
                (faculty) => LmuListItem.action(
                  leadingArea: FacultyNumberWidget(facultyId: faculty.id),
                  actionType: LmuListItemAction.chevron,
                  title: faculty.name,
                  onTap: () => LinksOverviewRoute(facultyId: faculty.id).push(context),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }
}
