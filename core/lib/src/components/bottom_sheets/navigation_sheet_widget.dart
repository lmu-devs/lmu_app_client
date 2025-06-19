import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_api/explore.dart';
import 'package:core_routes/explore.dart';

import '../../../api.dart';
import '../../../components.dart';
import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../themes.dart';
import '../../../utils.dart';
import '../../constants/constants.dart';

class NavigationSheet extends StatelessWidget {
  const NavigationSheet({super.key, required this.id, required this.location});

  final String id;
  final LocationModel location;

  void _openExternalApplication({
    required BuildContext context,
    required double latitude,
    required double longitude,
    required bool isApple,
  }) async {
    final String appleMapsUrl = 'maps:0,0?q=$latitude,$longitude';
    final String googleMapsUrlAndroid =
        'google.navigation:q=$latitude,$longitude';
    final String googleMapsUrlIOS = 'comgooglemaps://?q=$latitude,$longitude';
    final String googleMapsUrlWeb =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    final bool isGoogleMapsInstalled = await LmuUrlLauncher.canLaunch(
        url: Platform.isIOS ? googleMapsUrlIOS : googleMapsUrlAndroid);

    final String urlToLaunch = isApple
        ? appleMapsUrl
        : isGoogleMapsInstalled
            ? (Platform.isIOS ? googleMapsUrlIOS : googleMapsUrlAndroid)
            : googleMapsUrlWeb;

    if (context.mounted) {
      LmuUrlLauncher.launchWebsite(
        context: context,
        url: urlToLaunch,
        mode: LmuUrlLauncherMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentRoutePath = GoRouter.of(context).state.fullPath ?? '';
    const String exploreRoutePath = ExploreMainRoute.path;
    final bool isAlreadyOnExplorePage = currentRoutePath == exploreRoutePath;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.size_8,
            top: LmuSizes.size_4,
            bottom: LmuSizes.size_8,
          ),
          child: LmuText.body(
            context.locals.explore.openWith,
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
        ),
        if (!isAlreadyOnExplorePage)
          LmuListItem.base(
            title: context.locals.explore.inAppMaps,
            leadingArea: Image.asset(
              getPngAssetTheme('assets/app_icon'),
              package: 'launch_flow',
              height: LmuIconSizes.large,
              width: LmuIconSizes.large,
            ),
            onTap: () {
              Navigator.pop(context);
              const ExploreMainRoute().go(context);
              GetIt.I<ExploreApi>().selectLocation(id);
            },
          ),
        if (Platform.isIOS)
          LmuListItem.base(
            title: context.locals.explore.appleMaps,
            leadingArea: Image.asset(
              getPngAssetTheme('assets/apple_maps_icon'),
              package: 'explore',
              height: LmuIconSizes.large,
              width: LmuIconSizes.large,
            ),
            onTap: () {
              _openExternalApplication(
                context: context,
                isApple: true,
                latitude: location.latitude,
                longitude: location.longitude,
              );
              Navigator.pop(context);
            },
          ),
        LmuListItem.base(
          title: context.locals.explore.googleMaps,
          leadingArea: Image.asset(
            getPngAssetTheme('assets/google_maps_icon'),
            package: 'explore',
            height: LmuIconSizes.large,
            width: LmuIconSizes.large,
          ),
          onTap: () {
            _openExternalApplication(
              context: context,
              isApple: false,
              latitude: location.latitude,
              longitude: location.longitude,
            );
            Navigator.pop(context);
          },
        ),
        const Padding(
            padding: EdgeInsets.symmetric(
              vertical: LmuSizes.size_4,
              horizontal: LmuSizes.size_8,
            ),
            child: LmuDivider()),
        LmuListItem.base(
          title: context.locals.explore.copyToClipboard,
          leadingArea: const Padding(
            padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_6),
            child: Icon(LucideIcons.copy, size: LmuIconSizes.mediumSmall),
          ),
          onTap: () {
            Navigator.pop(context);
            CopyToClipboardUtil.copyToClipboard(
              context: context,
              copiedText: location.address,
              message: context.locals.explore.copiedToClipboard,
            );
          },
        ),
      ],
    );
  }
}
