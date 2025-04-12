import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../routes/explore_routes.dart';
import '../services/explore_map_service.dart';

class ExploreMapOverlay extends StatelessWidget {
  const ExploreMapOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();

    return Column(
      children: [
        LmuIconButton(
          icon: LucideIcons.layers,
          backgroundColor: context.colors.neutralColors.backgroundColors.tile,
          onPressed: () => LmuBottomSheet.show(
            context,
            content: const _LayerBottomSheetContent(),
          ),
        ),
        const SizedBox(height: 8),
        LmuIconButton(
          icon: LucideIcons.locate,
          backgroundColor: context.colors.neutralColors.backgroundColors.tile,
          onPressed: () async {
            await PermissionsService.isLocationPermissionGranted().then(
              (isPermissionGranted) async {
                if (!isPermissionGranted) {
                  await PermissionsService.showLocationPermissionDeniedDialog(context);
                  return;
                }
                await PermissionsService.isLocationServicesEnabled().then(
                  (isLocationServicesEnabled) async {
                    if (!isLocationServicesEnabled) {
                      await PermissionsService.showLocationServiceDisabledDialog(context);
                      return;
                    }
                  },
                );
              },
            );
            mapService.focuUserLocation();
          },
        ),
        const SizedBox(height: 8),
        LmuIconButton(
          icon: LucideIcons.search,
          backgroundColor: context.colors.neutralColors.backgroundColors.tile,
          onPressed: () => const ExploreSearchRoute().go(context),
        ),
      ],
    );
  }
}

class _LayerBottomSheetContent extends StatelessWidget {
  const _LayerBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = ExploreLocationFilter.values;
    final mapService = GetIt.I<ExploreMapService>();

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LmuText.h1('Choose Filter'),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filters.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              final filter = filters[index];

              return GestureDetector(
                onTap: () {
                  mapService.updateFilter(filter);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/explore_layer_example.png',
                              package: "explore",
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: context.colors.neutralColors.backgroundColors.tile.withOpacity(0.9),
                          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_12, vertical: LmuSizes.size_8),
                          child: LmuText.body(
                            _labelForFilter(filter),
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: mapService.exploreLocationFilterNotifier,
                        builder: (context, selectedFilter, child) {
                          final isSelected = selectedFilter == filter;

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
                              border: isSelected
                                  ? Border.all(
                                      color: context.colors.brandColors.textColors.strongColors.base,
                                      width: 2,
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _labelForFilter(ExploreLocationFilter filter) {
    switch (filter) {
      case ExploreLocationFilter.all:
        return 'All';
      case ExploreLocationFilter.mensa:
        return 'Mensa';
      case ExploreLocationFilter.building:
        return 'Building';
      case ExploreLocationFilter.cinema:
        return 'Cinema';
    }
  }
}
