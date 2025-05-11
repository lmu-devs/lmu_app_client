import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';

import '../extensions/opening_hours_extensions.dart';
import '../repository/api/api.dart';
import '../widgets/library_status_item.dart';

class LibraryAreasPage extends StatelessWidget {
  const LibraryAreasPage({super.key, required this.library});

  final LibraryModel library;

  @override
  Widget build(BuildContext context) {
    final expandedAreaIndexNotifier = ValueNotifier<int?>(null);

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.libraries.areas,
        leadingAction: LeadingAction.back,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.size_16,
            right: LmuSizes.size_16,
            top: LmuSizes.size_8,
            bottom: LmuSizes.size_96,
          ),
          child: ValueListenableBuilder<int?>(
            valueListenable: expandedAreaIndexNotifier,
            builder: (context, expandedAreaIndex, _) {
              return Column(
                children: library.areas.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final area = entry.value;
                    final isExpanded = expandedAreaIndex == index;
                    final status = area.getStyledStatus(context);
                    final details = area.openingHours?.days ?? [];

                    return Padding(
                      padding: const EdgeInsets.only(top: LmuSizes.size_8),
                      child: LmuContentTile(
                        contentList: [
                          LmuListItem.action(
                            actionType: LmuListItemAction.dropdown,
                            title: area.name,
                            onTap: () => expandedAreaIndexNotifier.value =
                                expandedAreaIndexNotifier.value == index ? null : index,
                          ),
                          if (isExpanded)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: LmuSizes.size_12,
                                vertical: LmuSizes.size_4,
                              ),
                              child: Column(
                                children: details
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => buildLibraryStatusItem(
                                        entry: entry,
                                        appLocalizations: context.locals.app,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
