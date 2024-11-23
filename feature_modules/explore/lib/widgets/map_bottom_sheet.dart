import 'dart:io';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:mensa/mensa.dart';

import 'bottom_sheet_sizes.dart';

class MapBottomSheet extends StatelessWidget {
  final ValueNotifier<MensaModel?> selectedMensaNotifier;
  final DraggableScrollableController sheetController;

  MapBottomSheet({
    required this.selectedMensaNotifier,
    required this.sheetController,
    super.key,
  });

  final ValueNotifier<List<String>> favoriteMensasNotifier =
      GetIt.I.get<MensaUserPreferencesService>().favoriteMensaIdsNotifier;

  void _animateSheet(MensaModel? selectedMensa) {
    if (selectedMensa != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sheetController.animateTo(
          SheetSizes.medium.size,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sheetController.animateTo(
          SheetSizes.small.size,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MensaModel?>(
      valueListenable: selectedMensaNotifier,
      builder: (context, selectedMensa, child) {
        _animateSheet(selectedMensa);

        return DraggableScrollableSheet(
          controller: sheetController,
          initialChildSize: SheetSizes.small.size,
          minChildSize: SheetSizes.small.size,
          maxChildSize: SheetSizes.medium.size,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(LmuSizes.mediumLarge),
              decoration: BoxDecoration(
                color: context.colors.neutralColors.backgroundColors.base,
                border: Border(
                  top: BorderSide(
                    color: context.colors.neutralColors.backgroundColors.strongColors.base,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    selectedMensa != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: LmuSizes.small),
                            child: ValueListenableBuilder<List<String>>(
                              valueListenable: favoriteMensasNotifier,
                              builder: (context, favoriteMensas, _) {
                                return MensaOverviewTile(
                                  mensaModel: selectedMensa,
                                  isFavorite: favoriteMensas.contains(selectedMensa.canteenId),
                                  hasLargeImage: false,
                                  hasButton: true,
                                  buttonText: context.locals.explore.navigate,
                                  buttonAction: () => LmuBottomSheet.show(
                                    context,
                                    content: NavigationSheet(mensaLocation: selectedMensa.location),
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: LmuSizes.medium,
                        horizontal: LmuSizes.mediumLarge,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.neutralColors.backgroundColors.tile,
                        borderRadius: const BorderRadius.all(Radius.circular(LmuRadiusSizes.medium)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              selectedMensa?.name == null
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: LmuSizes.mediumLarge),
                                      child: Icon(
                                        LucideIcons.search,
                                        size: LmuSizes.xlarge,
                                        color: context.colors.neutralColors.textColors.weakColors.base,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              LmuText.bodySmall(selectedMensa?.name ?? context.locals.app.search),
                            ],
                          ),
                          selectedMensa != null
                              ? GestureDetector(
                                  onTap: () => selectedMensaNotifier.value = null,
                                  child: Icon(
                                    LucideIcons.x,
                                    size: LmuSizes.xlarge,
                                    color: context.colors.neutralColors.textColors.strongColors.base,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class NavigationSheet extends StatelessWidget {
  const NavigationSheet({
    super.key,
    required this.mensaLocation,
  });

  final MensaLocationData mensaLocation;

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

  String _getAssetTheme(BuildContext context, String asset) {
    if (Provider.of<ThemeProvider>(context, listen: false).themeMode == ThemeMode.light) {
      return '${asset}_light.png';
    } else if (Provider.of<ThemeProvider>(context, listen: false).themeMode == ThemeMode.dark) {
      return '${asset}_dark.png';
    } else {
      return MediaQuery.of(context).platformBrightness == Brightness.light ? '${asset}_light.png' : '${asset}_dark.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: LmuSizes.mediumSmall,
            top: LmuSizes.small,
            bottom: LmuSizes.mediumSmall,
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
              _getAssetTheme(context, 'assets/apple_maps_icon'),
              package: 'explore',
              height: LmuIconSizes.medium,
              width: LmuIconSizes.medium,
            ),
            onTap: () => _openExternalApplication(
              context: context,
              isApple: true,
              latitude: mensaLocation.latitude,
              longitude: mensaLocation.longitude,
            ),
          ),
        LmuListItem.base(
          title: context.locals.explore.googleMaps,
          leadingArea: Image.asset(
            _getAssetTheme(context, 'assets/google_maps_icon'),
            package: 'explore',
            height: LmuIconSizes.medium,
            width: LmuIconSizes.medium,
          ),
          onTap: () => _openExternalApplication(
            context: context,
            isApple: false,
            latitude: mensaLocation.latitude,
            longitude: mensaLocation.longitude,
          ),
        ),
      ],
    );
  }
}
