import 'package:core/components.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/explore.dart';
import 'package:core_routes/libraries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../repository/api/api.dart';
import '../repository/api/enums/sort_options.dart';
import '../services/libraries_user_preference_service.dart';

class LibrariesOverviewButtonSection extends StatelessWidget {
  const LibrariesOverviewButtonSection({super.key, required this.libraries});

  final List<LibraryModel> libraries;

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    final userPreferencesService = GetIt.I.get<LibrariesUserPreferenceService>();
    final isOpenNowFilterNotifier = userPreferencesService.isOpenNowFilterNotifier;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: LmuButtonRow(
        buttons: [
          LmuMapImageButton(
            onTap: () {
              const ExploreMainRoute().go(context);
              GetIt.I<ExploreApi>().applyFilter(ExploreFilterType.library);
            },
          ),
          LmuIconButton(
            icon: LucideIcons.search,
            onPressed: () => const LibrariesSearchRoute().go(context),
          ),
          LmuSortingButton<SortOption>(
            sortOptionNotifier: userPreferencesService.sortOptionNotifier,
            options: SortOption.values,
            titleBuilder: (option, context) => option.title(context.locals.canteen),
            iconBuilder: (option) => option.icon,
            onOptionSelected: (sortOption, context) async {
              if (sortOption == SortOption.distance) {
                bool dontSort = false;
                await PermissionsService.isLocationPermissionGranted().then(
                      (isPermissionGranted) async {
                    if (!isPermissionGranted && context.mounted) {
                      dontSort = true;
                      await PermissionsService.showLocationPermissionDeniedDialog(context);
                    }
                    await PermissionsService.isLocationServicesEnabled().then(
                          (isLocationServicesEnabled) async {
                        if (!isLocationServicesEnabled && context.mounted) {
                          dontSort = true;
                          await PermissionsService.showLocationServiceDisabledDialog(context);
                        }
                        if (isPermissionGranted && isLocationServicesEnabled) {
                          GetIt.I.get<LocationService>().updatePosition();
                        }
                      },
                    );
                  },
                );
                if (dontSort) return;
              }

              userPreferencesService.sortOptionNotifier.value = sortOption;
              userPreferencesService.sortLibraries(libraries);
              userPreferencesService.updateSortOption(sortOption);

              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          ),
          ValueListenableBuilder(
            valueListenable: isOpenNowFilterNotifier,
            builder: (context, isOpenNowFilterActive, _) {
              return LmuButton(
                title: localizations.openNow,
                emphasis: isOpenNowFilterActive ? ButtonEmphasis.primary : ButtonEmphasis.secondary,
                action: isOpenNowFilterActive ? ButtonAction.contrast : ButtonAction.base,
                onTap: () => isOpenNowFilterNotifier.value = !isOpenNowFilterNotifier.value,
              );
            },
          ),
        ],
      ),
    );
  }
}

extension on SortOption {
  IconData get icon {
    return switch (this) {
      SortOption.alphabetically => LucideIcons.a_large_small,
      SortOption.distance => LucideIcons.arrow_right_from_line,
      SortOption.rating => LucideIcons.star,
    };
  }

  String title(CanteenLocalizations localizations) {
    return switch (this) {
      SortOption.alphabetically => localizations.alphabetically,
      SortOption.distance => localizations.distance,
      SortOption.rating => localizations.rating,
    };
  }
}
