import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/sports_model.dart';
import '../services/sports_state_service.dart';
import 'sports_grouped_course_section.dart';
import 'sports_info_section.dart';

class SportsContentView extends StatefulWidget {
  const SportsContentView({super.key, required this.sports});

  final List<SportsModel> sports;

  @override
  State<SportsContentView> createState() => _SportsContentViewState();
}

class _SportsContentViewState extends State<SportsContentView> {
  late final LmuSearchController _searchController;
  late final List<LmuSearchInput> _searchInputs;

  final sportsStateService = GetIt.I.get<SportsStateService>();

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
    _searchInputs = widget.sports.map((sport) {
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
              SportsInfoSection(sports: widget.sports),
              const SportsGroupedCourseSection(),
              const SizedBox(height: LmuSizes.size_96)
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
          ),
        ),
      ],
    );
  }
}

class LmuSearchOverlay extends StatelessWidget {
  const LmuSearchOverlay({
    super.key,
    required this.searchController,
    required this.searchInputs,
    this.quickFilterButtons,
  });

  final LmuSearchController searchController;
  final List<LmuSearchInput> searchInputs;
  final List<LmuButton>? quickFilterButtons;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colors.neutralColors.backgroundColors.base,
          border: Border(
            top: BorderSide(
              color: colors.neutralColors.borderColors.seperatorLight,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuSearchBar(searchController: searchController, searchInputs: searchInputs),
            const SizedBox(height: LmuSizes.size_16),
            if (quickFilterButtons != null) LmuButtonRow(buttons: quickFilterButtons!),
            if (quickFilterButtons != null) const SizedBox(height: LmuSizes.size_16),
          ],
        ),
      ),
    );
  }
}
