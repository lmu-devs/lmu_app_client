import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
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
          ValueListenableBuilder(
            valueListenable: userPreferencesService.sortOptionNotifier,
            builder: (context, activeSortOption, _) {
              return LmuButton(
                title: SortOption.values.firstWhere((option) => option == activeSortOption).title(localizations),
                emphasis: ButtonEmphasis.secondary,
                trailingIcon: LucideIcons.chevron_down,
                onTap: () => _showSortOptionActionSheet(context),
              );
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

  void _showSortOptionActionSheet(BuildContext context) {
    LmuBottomSheet.show(
      context,
      content: _SortOptionActionSheetContent(libraries: libraries),
    );
  }
}

class _SortOptionActionSheetContent extends StatelessWidget {
  const _SortOptionActionSheetContent({required this.libraries});

  final List<LibraryModel> libraries;

  @override
  Widget build(BuildContext context) {
    final userPreferencesService = GetIt.I.get<LibrariesUserPreferenceService>();
    final sortOptionNotifier = userPreferencesService.sortOptionNotifier;

    return ValueListenableBuilder(
      valueListenable: sortOptionNotifier,
      builder: (context, activeValue, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...SortOption.values.map(
              (sortOption) {
                final isActive = sortOption == activeValue;
                final textColor = activeValue.textColor(context.colors, isActive: isActive);

                return Column(
                  children: [
                    LmuListItem.base(
                      title: isActive ? sortOption.title(context.locals.canteen) : null,
                      titleColor: textColor,
                      subtitle: isActive ? null : sortOption.title(context.locals.canteen),
                      mainContentAlignment: MainContentAlignment.center,
                      leadingArea: LmuIcon(
                        icon: sortOption.icon,
                        size: LmuIconSizes.medium,
                        color: textColor,
                      ),
                      onTap: () async {
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

                        sortOptionNotifier.value = sortOption;
                        userPreferencesService.sortLibraries(libraries);
                        userPreferencesService.updateSortOption(sortOption);
                        Future.delayed(
                          const Duration(milliseconds: 100),
                          () {
                            if (context.mounted) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          },
                        );
                      },
                    ),
                    if (sortOption != SortOption.values.last) const SizedBox(height: LmuSizes.size_8),
                  ],
                );
              },
            ),
          ],
        );
      },
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

  Color textColor(LmuColors colors, {required bool isActive}) {
    if (isActive) {
      return colors.brandColors.textColors.strongColors.base;
    }
    return colors.neutralColors.textColors.mediumColors.base;
  }
}
