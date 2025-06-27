import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/people_favorites_section.dart';
import '../component/people_page_loading.dart';
import '../component/people_suggestion_tile.dart';
import '../viewmodel/people_page_driver.dart';

class PeoplePage extends DrivableWidget<PeoplePageDriver> {
  PeoplePage({super.key});

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.peoples.people,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuPageAnimationWrapper(
            child: Align(
              //key: ValueKey("people_page_${driver.isLoading}"),
              alignment: Alignment.topCenter,
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  Widget get content {
    if (driver.isLoading) return const PeoplePageLoading(); // replace with skeleton loading

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /*const SizedBox(height: LmuSizes.size_16),
        // --- Suchfeld mit Lupe ---
        TextField(
          decoration: InputDecoration(
            hintText: 'Suchen' ?? 'Person suchen',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          ),
          onChanged: driver.onSearchChanged,
        ),*/
        const SizedBox(height: LmuSizes.size_16),
        // --- Rest wie gehabt ---

        LmuContentTile(
          content: LmuListItem.action(
            title: driver.allPeopleTitle,
            trailingTitle: driver.allPeopleCount,
            actionType: LmuListItemAction.chevron,
            onTap: driver.onAllPeoplePressed,
          ),
        ),
        const SizedBox(height: LmuSizes.size_16),
        PeopleFavoritesSection(people: driver.favorites),
        const SizedBox(height: LmuSizes.size_16),
        LmuTileHeadline.base(
          title: _context.locals.peoples.faculty,
        ),
        LmuContentTile(
          contentList: driver.peopleCategories
              .mapIndexed(
                (index, faculty) => LmuListItem.action(
                  key: Key("people_category_${faculty.hashCode}"),
                  title: faculty.name,
                  subtitle: faculty.description,
                  leadingArea: LmuInListBlurEmoji(emoji: faculty.emoji),
                  trailingTitle: faculty.peoples.length.toString(),
                  hasDivider: index != driver.peopleCategories.length - 1,
                  actionType: LmuListItemAction.chevron,
                  onTap: () => driver.onFacultyPressed(faculty),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: LmuSizes.size_32),
        const PeopleSuggestionTile(),
        const SizedBox(height: LmuSizes.size_96),
      ],
    );
  }

  @override
  WidgetDriverProvider<PeoplePageDriver> get driverProvider => $PeoplePageDriverProvider();
}
