import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../services/explore_map_service.dart';

class ExploreLocationButton extends StatelessWidget {
  const ExploreLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mapService = GetIt.I<ExploreMapService>();

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: context.colors.neutralColors.backgroundColors.tile,
        borderRadius: BorderRadius.circular(LmuSizes.size_8),
        boxShadow: [
          BoxShadow(
            color: context.colors.neutralColors.borderColors.seperatorLight,
            offset: const Offset(0, 1),
            blurRadius: 1,
            spreadRadius: 0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () async {
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
          mapService.focusUserLocation().then(
            (value) {
              if (!value && context.mounted) {
                LmuToast.show(
                  context: context,
                  message: context.locals.explore.errorFocusUser,
                  type: ToastType.error,
                );
              }
            },
          );
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: mapService.isUserFocusedNotifier,
          builder: (context, isUserLocationFocused, child) {
            return LocationIcon(
              size: LmuIconSizes.medium,
              isFocused: isUserLocationFocused,
            );
          },
        ),
      ),
    );
  }
}
