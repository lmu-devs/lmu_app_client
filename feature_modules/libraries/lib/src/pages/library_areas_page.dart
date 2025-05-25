import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../extensions/opening_hours_extensions.dart';
import '../repository/api/api.dart';
import '../services/libraries_status_update_service.dart';
import '../widgets/library_status_item.dart';

class LibraryAreasPage extends StatelessWidget {
  const LibraryAreasPage({super.key, required this.library});

  final LibraryModel library;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: library.areas.map(
              (area) {
                final isAreaExpandedNotifier = ValueNotifier<bool>(false);
                final details = area.openingHours ?? [];

                return Padding(
                  padding: const EdgeInsets.only(top: LmuSizes.size_8),
                  child: LmuContentTile(
                    contentList: [
                      ListenableBuilder(
                        listenable: GetIt.I<LibrariesStatusUpdateService>(),
                        builder: (context, child) {
                          final statusStyle = area.getStyledStatus(context);

                          return LmuListItem.action(
                            actionType: LmuListItemAction.dropdown,
                            title: area.name,
                            subtitle: statusStyle.text,
                            subtitleTextColor: statusStyle.color,
                            onTap: () => isAreaExpandedNotifier.value = !isAreaExpandedNotifier.value,
                          );
                        },
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: isAreaExpandedNotifier,
                        builder: (context, isExpanded, _) {
                          return AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: AnimatedSwitcher(
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
                                  child: SizeTransition(
                                    sizeFactor: animation,
                                    child: child,
                                  ),
                                );
                              },
                              switchInCurve: LmuAnimations.slowSmooth,
                              switchOutCurve: LmuAnimations.slowSmooth.flipped,
                              duration: const Duration(milliseconds: 300),
                              child: isExpanded
                                  ? Padding(
                                      key: ValueKey(isExpanded),
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
                                                openingHours: entry.value,
                                                context: context,
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                  : SizedBox.shrink(key: ValueKey(isExpanded)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
