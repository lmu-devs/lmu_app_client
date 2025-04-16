import 'dart:io';

import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../services/explore_map_service.dart';

typedef AttributionEntry = ({String name, String url});

class ExploreMapAttribution extends StatelessWidget {
  const ExploreMapAttribution({super.key});

  static const _attributions = <AttributionEntry>[
    (name: "© Mapbox", url: "https://www.mapbox.com/"),
    (name: "© OpenStreetMap", url: "http://www.openstreetmap.org/copyright"),
    (name: "Improve this map", url: "https://apps.mapbox.com/feedback/#/"),
  ];

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Row(
      children: [
        Image.asset(
          'assets/mapbox-logo-${isLight ? "black" : "white"}.png',
          package: "explore",
          fit: BoxFit.cover,
          height: 20,
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            final isIos = Platform.isIOS || Platform.isMacOS;
            if (isIos) {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: const Text('Mapbox iOS SDK'),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      onPressed: () {
                        LmuUrlLauncher.launchWebsite(
                          context: context,
                          url: _attributions[0].url,
                          mode: LmuUrlLauncherMode.externalApplication,
                        );
                      },
                      child: Text(_attributions[0].name),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        LmuUrlLauncher.launchWebsite(
                          context: context,
                          url: _attributions[1].url,
                          mode: LmuUrlLauncherMode.externalApplication,
                        );
                      },
                      child: Text(_attributions[1].name),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        final mapController = GetIt.I.get<ExploreMapService>().mapController;
                        final camera = mapController.camera;
                        final lat = camera.center.latitude;
                        final lng = camera.center.longitude;
                        final zoom = camera.zoom;
                        final link = "${_attributions[2].url}{$lng}/{$lat}/{$zoom}";
                        LmuUrlLauncher.launchWebsite(
                          context: context,
                          url: link,
                          mode: LmuUrlLauncherMode.externalApplication,
                        );
                      },
                      child: Text(_attributions[2].name),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Mapbox Maps SDK for Android'),
                  titleTextStyle: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            LmuUrlLauncher.launchWebsite(
                              context: context,
                              url: _attributions[0].url,
                              mode: LmuUrlLauncherMode.externalApplication,
                            );
                          },
                          child: Text(_attributions[0].name),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            LmuUrlLauncher.launchWebsite(
                              context: context,
                              url: _attributions[1].url,
                              mode: LmuUrlLauncherMode.externalApplication,
                            );
                          },
                          child: Text(_attributions[1].name),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            final mapController = GetIt.I.get<ExploreMapService>().mapController;
                            final camera = mapController.camera;
                            final lat = camera.center.latitude;
                            final lng = camera.center.longitude;
                            final zoom = camera.zoom;
                            final link = "${_attributions[2].url}{$lng}/{$lat}/{$zoom}";
                            LmuUrlLauncher.launchWebsite(
                              context: context,
                              url: link,
                              mode: LmuUrlLauncherMode.externalApplication,
                            );
                          },
                          child: Text(_attributions[2].name),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          child: const LmuIcon(icon: LucideIcons.info, size: 20),
        ),
      ],
    );
  }
}
