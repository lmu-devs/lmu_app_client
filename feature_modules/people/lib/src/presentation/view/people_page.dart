import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

import '../component/alphabetic_scrollbar.dart';
import '../viewmodel/people_page_driver.dart';

class PeoplePage extends DrivableWidget<PeoplePageDriver> {
  PeoplePage({super.key});

  final Map<String, GlobalKey> _groupKeys = {};
  final ScrollController _scrollController = ScrollController();

  void _scrollToKey(String letter) {
    final key = _groupKeys[letter];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedPeople = driver.groupedPeople;
    final groupEntries = groupedPeople.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    for (final entry in groupEntries) {
      _groupKeys.putIfAbsent(entry.key, () => GlobalKey());
    }

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.facultyTitle,
        leadingAction: LeadingAction.back,
      ),
      customScrollController: _scrollController,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              LmuSizes.size_16,
              0,
              LmuSizes.size_48,
              LmuSizes.size_96,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final entry in groupEntries) ...[
                  LmuTileHeadline.base(
                    key: _groupKeys[entry.key],
                    title: entry.key,
                  ),
                  LmuContentTile(
                    contentList: entry.value.map((person) {
                      return LmuListItem.action(
                        title:
                            '${person.academicDegree != null && person.academicDegree!.isNotEmpty ? person.academicDegree! + ' ' : ''}${person.name} ${person.surname}',
                        subtitle: person.role,
                        actionType: LmuListItemAction.chevron,
                        onTap: () => driver.onPeopleCardPressed(person),
                      );
                    }).toList(),
                  ),
                  if (entry.key != groupEntries.last.key) const SizedBox(height: LmuSizes.size_32),
                ],
              ],
            ),
          ),
          if (groupEntries.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: AlphabetScrollbar(
                letters: groupEntries.map((e) => e.key).toList(),
                onLetterSelected: _scrollToKey,
              ),
            ),
        ],
      ),
    );
  }

  @override
  WidgetDriverProvider<PeoplePageDriver> get driverProvider => $PeoplePageDriverProvider();
}
