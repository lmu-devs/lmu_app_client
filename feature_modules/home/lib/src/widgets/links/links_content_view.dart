import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import '../../repository/api/models/links/link_model.dart';
import 'favorite_link_section.dart';
import 'link_button_section.dart';
import 'link_card.dart';

class LinksContentView extends StatefulWidget {
  const LinksContentView({super.key, required this.links});

  final List<LinkModel> links;

  @override
  State<LinksContentView> createState() => _LinksContentViewState();
}

class _LinksContentViewState extends State<LinksContentView> {
  List<LinkModel> get links => widget.links;

  Map<String, List<LinkModel>> get _groupedLinks => _groupLinks(widget.links);

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
                children: [
                  const SizedBox(height: LmuSizes.size_16),
                  FavoriteLinkSection(links: widget.links),
                  const LinkButtonSection(),
                  const SizedBox(height: LmuSizes.size_16),
                  Column(
                    children: _groupedLinks.entries.map(
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
                  GetIt.I<FeedbackService>().getMissingItemInput(
                    context.locals.home.linkSuggestion,
                    'LinksScreen',
                  ),
                  const SizedBox(height: LmuSizes.size_72 + LmuSizes.size_96),
                ],
              ),
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
