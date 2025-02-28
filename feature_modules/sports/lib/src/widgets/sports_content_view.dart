import 'package:core/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/sports_model.dart';
import '../services/sports_state_service.dart';
import 'sports_grouped_course_section.dart';
import 'sports_info_section.dart';

class SportsContentView extends StatefulWidget {
  const SportsContentView({super.key, required this.sports});

  final SportsModel sports;

  @override
  State<SportsContentView> createState() => _SportsContentViewState();
}

class _SportsContentViewState extends State<SportsContentView> {
  late final LmuSearchController _searchController;
  late final List<LmuSearchInput> _searchInputs;

  final sportsStateService = GetIt.I.get<SportsStateService>();

  SportsModel get _sports => widget.sports;

  @override
  void initState() {
    super.initState();

    _searchController = LmuSearchController();

    _searchController.addListener(() {
      sportsStateService.searchValues(
        _searchController.value.map((input) => input.title).toList(),
        _searchController.noResult,
      );
    });
    _searchInputs = _sports.sportTypes.map((sport) {
      return LmuSearchInput(
        title: sport.title,
        id: sport.title,
        tags: sport.courses.map((course) => course.instructor).toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SportsInfoSection(sports: _sports),
              SportsGroupedCourseSection(sportsTypes: _sports.sportTypes),
              const SizedBox(height: 168)
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: LmuSearchOverlay(
            searchController: _searchController,
            searchInputs: _searchInputs,
            // bottomWidget: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     ValueListenableBuilder(
            //       valueListenable: _filterOptionsNotifier,
            //       builder: (context, value, _) {
            //         final isAllActive = value[SportsFilterOption.all]!;
            //         final isAvailableActive = value[SportsFilterOption.available]!;
            //         return LmuButtonRow(
            //           hasHorizontalPadding: false,
            //           buttons: [
            //             LmuButton(
            //               emphasis: isAllActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            //               action: isAllActive ? ButtonAction.contrast : ButtonAction.base,
            //               title: "Alle",
            //               onTap: () => sportsStateService.applyFilter(SportsFilterOption.all),
            //             ),
            //             LmuButton(
            //               emphasis: isAvailableActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
            //               action: isAvailableActive ? ButtonAction.contrast : ButtonAction.base,
            //               title: "Verfügbar",
            //               onTap: () => sportsStateService.applyFilter(SportsFilterOption.available),
            //             ),
            //           ],
            //         );
            //       },
            //     ),
            //     const SizedBox(height: LmuSizes.size_16),
            //   ],
            // ),
          ),
        ),
      ],
    );
  }
}
