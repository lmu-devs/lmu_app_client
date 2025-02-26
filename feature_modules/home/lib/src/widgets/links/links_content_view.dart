import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../repository/api/models/links/link_model.dart';
import '../../service/home_preferences_service.dart';
import 'link_card.dart';

class LinksContentView extends StatefulWidget {
  const LinksContentView({super.key, required this.links});

  final List<LinkModel> links;

  @override
  State<LinksContentView> createState() => _LinksContentViewState();
}

class _LinksContentViewState extends State<LinksContentView> {
  late final LmuSearchController _searchController;
  late List<LmuSearchInput> _searchInputs;
  Map<String, List<LinkModel>> _groupedLinks = {};

  @override
  void initState() {
    super.initState();

    _searchController = LmuSearchController();
    _searchController.addListener(_filterLinks);

    _searchInputs = widget.links
        .map((link) => LmuSearchInput(
              title: link.title,
              id: link.title,
              tags: link.aliases,
            ))
        .toList();

    _groupLinks(widget.links);
  }

  void _groupLinks(List<LinkModel> links) {
    final sortedLinks = List.from(links)..sort((a, b) => a.title.compareTo(b.title));
    _groupedLinks = {};
    for (var link in sortedLinks) {
      final firstLetter = link.title[0].toUpperCase();
      _groupedLinks.putIfAbsent(firstLetter, () => []).add(link);
    }
    setState(() {});
  }

  void _filterLinks() {
    final query = _searchController.value.map((input) => input.title.toLowerCase()).toList();
    if (query.isEmpty) {
      _groupLinks(widget.links);
    } else {
      final filtered = widget.links.where((link) => query.any((q) => link.title.toLowerCase().contains(q))).toList();
      _groupLinks(filtered);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LmuMasterAppBar(
          largeTitle: "Links",
          leadingAction: LeadingAction.back,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: LmuSizes.size_16),
                  ValueListenableBuilder<List<String>>(
                    valueListenable: GetIt.I<HomePreferencesService>().likedLinksNotifier,
                    builder: (context, likedLinkTitles, child) {
                      return likedLinkTitles.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StarIcon(
                                    disabledColor: context.colors.neutralColors.backgroundColors.strongColors.active),
                                const SizedBox(height: LmuSizes.size_12),
                                LmuContentTile(
                                  content: widget.links
                                      .where((link) => likedLinkTitles.contains(link.title))
                                      .map((link) => LinkCard(link: link))
                                      .toList(),
                                ),
                                const SizedBox(height: LmuSizes.size_16),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: LmuSizes.size_32),
                              child: PlaceholderTile(
                                minHeight: LmuSizes.size_72,
                                content: [
                                  LmuText.body(
                                    "Favorited links will appear here and on the home screen",
                                    color: context.colors.neutralColors.textColors.mediumColors.base,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                  Column(
                      children: _groupedLinks.entries.map((entry) {
                    return Column(
                      children: [
                        LmuTileHeadline.base(title: entry.key),
                        LmuContentTile(
                          content: entry.value.map((link) => LinkCard(link: link)).toList(),
                        ),
                        const SizedBox(height: LmuSizes.size_16),
                      ],
                    );
                  }).toList()),
                  const SizedBox(height: LmuSizes.size_96),
                ],
              ),
            ),
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
