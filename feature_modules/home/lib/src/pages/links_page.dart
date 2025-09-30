import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';

import 'pages.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFaculties = GetIt.I.get<FacultiesApi>().selectedFaculties;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: "Links",
        leadingAction: LeadingAction.back,
      ),
      body: selectedFaculties.length == 1
          ? LinksOverviewPage(facultyId: selectedFaculties.first.id)
          : const LinksFacultiesPage(),
    );
  }
}
