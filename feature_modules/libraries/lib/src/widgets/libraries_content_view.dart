import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../repository/api/models/library_model.dart';
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
                    return LmuAnimatedListView(
                      valueKey:
                          "${userPreferencesService.sortOptionNotifier.value} • ${sortedLibraries.map((library) => library.id).join()}",
                      itemCount: sortedLibraries.length,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                          valueListenable: userPreferencesService.favoriteLibraryIdsNotifier,
                          builder: (context, favoriteLibraryIds, _) {
                            final isFavorite = favoriteLibraryIds.contains(sortedLibraries[index].id);
                            return LibraryTile(
                              library: sortedLibraries[index],
                              isFavorite: isFavorite,
                              hasDivider: index != sortedLibraries.length - 1,
                              hasLargeImage: sortedLibraries[index].images.isNotEmpty,
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
