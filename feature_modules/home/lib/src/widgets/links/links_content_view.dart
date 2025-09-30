import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';
import 'package:shared_api/studies.dart';

import '../../repository/api/models/links/link_model.dart';
import 'favorite_link_section.dart';
import 'link_button_section.dart';
import 'link_card.dart';

class LinksContentView extends StatefulWidget {
  const LinksContentView({super.key, required this.facultyId, required this.links});

  final int facultyId;
  final List<LinkModel> links;

  @override
  State<LinksContentView> createState() => _LinksContentViewState();
}

class _LinksContentViewState extends State<LinksContentView> {
  int get facultyId => widget.facultyId;
  List<LinkModel> get links => widget.links;
  final allFaculties = GetIt.I.get<FacultiesApi>().allFaculties;
  final ValueNotifier<String?> _activeFilterNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    final locals = context.locals;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: ValueListenableBuilder<String?>(
          valueListenable: _activeFilterNotifier,
          builder: (context, activeFilter, child) {
            Map<String, List<LinkModel>> groupedLinks = _groupLinks(links, activeFilter);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LmuText(
                  context.locals.studies.facultiesSubtitle(
                    allFaculties.firstWhere((faculty) => faculty.id == facultyId).name),
                  color: context.colors.neutralColors.textColors.mediumColors.base,
                ),
                const SizedBox(height: LmuSizes.size_32),
                FavoriteLinkSection(links: widget.links),
                LinkButtonSection(
                  facultyId: facultyId,
                  activeFilter: activeFilter,
                  onFilterSelected: (filter) => _activeFilterNotifier.value = filter,
                ),
                const SizedBox(height: LmuSizes.size_16),
                Column(
                  children: groupedLinks.entries.map(
                    (entry) {
                      return Column(
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
                    },
                  ).toList(),
                ),
                const SizedBox(height: LmuSizes.size_6),
                LmuTileHeadline.base(title: locals.feedback.missingItemInput),
                LmuContentTile(
                  content: LmuListItem.base(
                    title: locals.home.linkSuggestion,
                    mainContentAlignment: MainContentAlignment.center,
                    leadingArea: const LeadingFancyIcons(icon: LucideIcons.megaphone),
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
            );
          },
        ),
      ),
    );
  }

  Map<String, List<LinkModel>> _groupLinks(List<LinkModel> links, String? activeFilter) {
    List<LinkModel> filteredLinks = links.where((link) => link.faculties.contains(facultyId.toString()) || link.faculties.isEmpty).toList();

    final sortedLinks = List.from(filteredLinks)..sort((a, b) => a.title.compareTo(b.title));
    final Map<String, List<LinkModel>> groupedLinks = {};
    for (var link in sortedLinks) {
      final firstLetter = link.title[0].toUpperCase();
      groupedLinks.putIfAbsent(firstLetter, () => []).add(link);
    }
    return groupedLinks;
  }
}
