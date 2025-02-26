import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import '../../repository/api/models/links/link_model.dart';
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
                children: _groupedLinks.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LmuTileHeadline.base(title: entry.key),
                      LmuContentTile(
                        content: entry.value.map((link) => LinkCard(link: link)).toList(),
                      ),
                      const SizedBox(height: LmuSizes.size_32),
                    ],
                  );
                }).toList()
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
