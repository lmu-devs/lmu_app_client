import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core_routes/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';
import 'package:shared_api/studies.dart';

import '../../extensions/extensions.dart';
import '../../repository/api/enums/link_sort_options.dart';
import '../../repository/api/models/links/link_model.dart';
import '../../service/home_preferences_service.dart';
import 'favorite_link_section.dart';
import 'link_button_section.dart';
import 'link_card.dart';

class LinksContentView extends StatelessWidget {
  const LinksContentView({
    super.key,
    required this.facultyId,
    required this.links,
  });

  final int facultyId;
  final List<LinkModel> links;

  @override
  Widget build(BuildContext context) {
    final locals = context.locals;
    final allFaculties = GetIt.I.get<FacultiesApi>().allFaculties;
    final homePreferencesService = GetIt.I.get<HomePreferencesService>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuText(
              context.locals.studies.facultiesSubtitle(allFaculties.firstWhere((faculty) => faculty.id == facultyId).name),
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
            const SizedBox(height: LmuSizes.size_32),
            FavoriteLinkSection(links: links),
            LinkButtonSection(
              facultyId: facultyId,
              sortOptionNotifier: homePreferencesService.linksSortOptionNotifier,
              onSortOptionChanged: (newOption) async {
                await homePreferencesService.updateLinksSorting(newOption);
              },
            ),
            const SizedBox(height: LmuSizes.size_16),
            ValueListenableBuilder<SortOption>(
              valueListenable: homePreferencesService.linksSortOptionNotifier,
              builder: (context, activeSortOption, _) {
                final filteredLinks = _getFilteredLinks(links);
                final sortedLinks = activeSortOption.sort(filteredLinks);

                final List<Widget> listItems;
                if (activeSortOption == SortOption.alphabetically) {
                  final groupedLinks = _groupLinksByFirstLetter(sortedLinks);
                  listItems = groupedLinks.entries.map((entry) {
                    return Column(
                      key: ValueKey(entry.key),
                      children: [
                        LmuTileHeadline.base(title: entry.key),
                        LmuContentTile(
                          content: Column(
                            children: entry.value.map((link) => LinkCard(link: link)).toList(),
                          ),
                        ),
                        const SizedBox(height: LmuSizes.size_32),
                      ],
                    );
                  }).toList();
                } else {
                  listItems = [
                    if (sortedLinks.isNotEmpty)
                      LmuContentTile(
                        content: Column(
                          children: sortedLinks.map((link) => LinkCard(link: link)).toList(),
                        ),
                      ),
                    const SizedBox(height: LmuSizes.size_32),
                  ];
                }

                return LmuAnimatedListView(
                  valueKey: "${activeSortOption.name} • ${sortedLinks.map((link) => link.id).join()}",
                  itemCount: listItems.length,
                  itemBuilder: (context, index) {
                    return listItems[index];
                  },
                );
              },
            ),
            LmuContentTile(
              content: LmuListItem.action(
                title: context.locals.studies.showAllFaculties,
                actionType: LmuListItemAction.chevron,
                onTap: () => const LinksFacultiesRoute().push(context),
              ),
            ),
            const SizedBox(height: LmuSizes.size_32),
            LmuTileHeadline.base(title: locals.feedback.missingItemInput),
            LmuContentTile(
              content: LmuListItem.base(
                title: locals.home.linkSuggestion,
                mainContentAlignment: MainContentAlignment.center,
                leadingArea:
                    const LeadingFancyIcons(icon: LucideIcons.megaphone),
                onTap: () {
                  GetIt.I.get<FeedbackApi>().showFeedback(
                        context,
                        args: FeedbackArgs(
                          type: FeedbackType.suggestion,
                          origin: 'LinksScreen',
                          title: locals.home.linkSuggestion,
                          description: locals.home.linkSuggestionDescription,
                          inputHint: locals.home.linkSuggestionHint,
                        ),
                      );
                },
              ),
            ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }

  List<LinkModel> _getFilteredLinks(List<LinkModel> allLinks) {
    return allLinks
        .where((link) =>
            link.faculties.contains(facultyId.toString()) ||
            link.faculties.isEmpty)
        .toList();
  }

  Map<String, List<LinkModel>> _groupLinksByFirstLetter(List<LinkModel> sortedLinks) {
    final Map<String, List<LinkModel>> groupedLinks = {};
    for (var link in sortedLinks) {
      if (link.title.isNotEmpty) {
        final firstLetter = link.title[0].toUpperCase();
        groupedLinks.putIfAbsent(firstLetter, () => []).add(link);
      }
    }
    return groupedLinks;
  }
}
