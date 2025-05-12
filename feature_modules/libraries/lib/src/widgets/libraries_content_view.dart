import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../extensions/opening_hours_extensions.dart';
import '../repository/api/models/library_model.dart';
import '../services/libraries_status_update_service.dart';
import '../services/libraries_user_preference_service.dart';
import 'favorite_libraries_section.dart';
import 'libraries_overview_button_section.dart';
import 'library_tile.dart';

class LibrariesContentView extends StatefulWidget {
  const LibrariesContentView({
    super.key,
    required this.libraries,
  });

  final List<LibraryModel> libraries;

  @override
  State<LibrariesContentView> createState() => _LibrariesContentViewState();
}

class _LibrariesContentViewState extends State<LibrariesContentView> {
  List<LibraryModel> get _libraries => widget.libraries;
  final userPreferencesService = GetIt.I.get<LibrariesUserPreferenceService>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                LmuTileHeadline.base(title: context.locals.app.favorites, customBottomPadding: LmuSizes.size_6),
                FavoriteLibrariesSection(libraries: _libraries),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: LmuTileHeadline.base(title: context.locals.libraries.allLibraries),
          ),
          LibrariesOverviewButtonSection(libraries: _libraries),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                const SizedBox(height: LmuSizes.size_16),
                ValueListenableBuilder(
                  valueListenable: userPreferencesService.sortedLibrariesNotifier,
                  builder: (context, sortedLibraries, _) {
                    return ListenableBuilder(
                      listenable: GetIt.I.get<LibrariesStatusUpdateService>(),
                      builder: (context, _) {
                        return ValueListenableBuilder(
                          valueListenable: userPreferencesService.isOpenNowFilterNotifier,
                          builder: (context, isFilterActive, _) {
                            final filteredLibraries = sortedLibraries.where(
                              (library) {
                                if (!isFilterActive) {
                                  return true;
                                }

                                library.areas.any((area) {
                                  final status = area.openingHours?.status;
                                  return status != null &&
                                      status != Status.closed &&
                                      status != Status.openingSoon &&
                                      status != Status.pause;
                                });

                                return false;
                              },
                            ).toList();

                            if (filteredLibraries.isEmpty) {
                              return Center(
                                child: LmuIssueType(
                                  message: context.locals.app.allClosed,
                                  hasSpacing: false,
                                ),
                              );
                            }

                            return LmuAnimatedListView(
                              valueKey:
                                  "${userPreferencesService.sortOptionNotifier.value} • ${filteredLibraries.map((library) => library.id).join()}",
                              itemCount: filteredLibraries.length,
                              itemBuilder: (context, index) {
                                return ValueListenableBuilder(
                                  valueListenable: userPreferencesService.favoriteLibraryIdsNotifier,
                                  builder: (context, favoriteLibraryIds, _) {
                                    final isFavorite = favoriteLibraryIds.contains(filteredLibraries[index].id);
                                    return LibraryTile(
                                      library: filteredLibraries[index],
                                      isFavorite: isFavorite,
                                      hasDivider: index != filteredLibraries.length - 1,
                                      hasLargeImage: filteredLibraries[index].images.isNotEmpty,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: LmuSizes.size_96),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
