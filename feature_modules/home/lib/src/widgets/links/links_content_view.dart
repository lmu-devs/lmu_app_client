import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';
import '../../repository/api/models/links/link_model.dart';
import 'favorite_link_section.dart';
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
  late ValueNotifier<List<LinkModel>> _filteredLinks;
  final ValueNotifier<bool> _isSearchActive = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _searchController = LmuSearchController();
    _searchInputs = widget.links
        .map((link) => LmuSearchInput(
              title: link.title,
              id: link.title,
              tags: link.aliases,
            ))
        .toList();

    _filteredLinks = ValueNotifier(widget.links);

    _searchController.addListener(_filterLinks);
  }

  void _filterLinks() {
    final query = _searchController.value.map((input) => input.title.toLowerCase()).toList();

    if (query.isEmpty) {
      _filteredLinks.value = widget.links;
    } else {
      _filteredLinks.value =
          widget.links.where((link) => query.any((q) => link.title.toLowerCase().contains(q))).toList();
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterLinks);
    _searchController.dispose();
    _filteredLinks.dispose();
    _isSearchActive.dispose();
    super.dispose();
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
                  ValueListenableBuilder<bool>(
                    valueListenable: _isSearchActive,
                    builder: (context, isActive, child) {
                      return FavoriteLinkSection(
                        links: widget.links,
                        isSearchActive: isActive,
                      );
                    },
                  ),
                  ValueListenableBuilder<List<LinkModel>>(
                    valueListenable: _filteredLinks,
                    builder: (context, filteredLinks, child) {
                      final groupedLinks = _groupLinks(filteredLinks);
                      return Column(
                        children: groupedLinks.entries.map((entry) {
                          return Column(
                            children: [
                              LmuTileHeadline.base(title: entry.key),
                              LmuContentTile(
                                content: entry.value.map((link) => LinkCard(link: link)).toList(),
                              ),
                              const SizedBox(height: LmuSizes.size_32),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: LmuSizes.size_6),
                  GetIt.I<FeedbackService>().getMissingItemInput(
                    context.locals.home.linkSuggestion,
                    'LinksScreen',
                  ),
                  const SizedBox(height: LmuSizes.size_96),
                  /// Search Bar Size
                  const SizedBox(height: LmuSizes.size_72),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Focus(
            onFocusChange: (hasFocus) => _isSearchActive.value = hasFocus,
            child: LmuSearchOverlay(
              searchController: _searchController,
              searchInputs: _searchInputs,
            ),
          ),
        ),
      ],
    );
  }

  Map<String, List<LinkModel>> _groupLinks(List<LinkModel> links) {
    final sortedLinks = List.from(links)..sort((a, b) => a.title.compareTo(b.title));
    final Map<String, List<LinkModel>> groupedLinks = {};
    for (var link in sortedLinks) {
      final firstLetter = link.title[0].toUpperCase();
      groupedLinks.putIfAbsent(firstLetter, () => []).add(link);
    }
    return groupedLinks;
  }
}
