import 'dart:io';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/src/constants/constants.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class NavigationSheet extends StatelessWidget {
  const NavigationSheet({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;

  void _openExternalApplication({
    required BuildContext context,
    required double latitude,
    required double longitude,
    required bool isApple,
  }) async {
    final String appleMapsUrl = 'maps:0,0?q=$latitude,$longitude';
    final String googleMapsUrlAndroid = 'google.navigation:q=$latitude,$longitude';
    final String googleMapsUrlIOS = 'comgooglemaps://?q=$latitude,$longitude';
    final String googleMapsUrlWeb = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    final bool isGoogleMapsInstalled =
        await LmuUrlLauncher.canLaunch(url: Platform.isIOS ? googleMapsUrlIOS : googleMapsUrlAndroid);

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

  void _copyToClipboard({
    required BuildContext context,
    required String copiedText,
  }) {
    Clipboard.setData(ClipboardData(text: copiedText));
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    LmuToast.show(
      context: context,
      message: context.locals.explore.copiedToClipboard,
      type: ToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
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
        if (Platform.isIOS)
          LmuListItem.base(
            title: context.locals.explore.appleMaps,
            leadingArea: Image.asset(
              getPngAssetTheme('assets/apple_maps_icon'),
              package: 'explore',
              height: LmuIconSizes.large,
              width: LmuIconSizes.large,
            ),
            onTap: () => _openExternalApplication(
              context: context,
              isApple: true,
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        LmuListItem.base(
          title: context.locals.explore.googleMaps,
          leadingArea: Image.asset(
            getPngAssetTheme('assets/google_maps_icon'),
            package: 'explore',
            height: LmuIconSizes.large,
            width: LmuIconSizes.large,
          ),
          onTap: () => _openExternalApplication(
            context: context,
            isApple: false,
            latitude: latitude,
            longitude: longitude,
          ),
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
          onTap: () => _copyToClipboard(context: context, copiedText: address),
        ),
      ],
    );
  }
}
