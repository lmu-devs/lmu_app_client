import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/svg.dart';

class ExploreAttribution extends StatelessWidget {
  const ExploreAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => LmuDialog.show(
        context: context,
        title: context.locals.explore.mapboxAttribution,
        customChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_8),
          child: LmuContentTile(
            contentList: [
              _attributionLink(
                label: '© Mapbox',
                url: 'https://www.mapbox.com/about/maps/',
                context: context,
              ),
              _attributionLink(
                label: '© OpenStreetMap',
                url: 'https://www.openstreetmap.org/about/',
                context: context,
              ),
              _attributionLink(
                label: 'Improve this map',
                url: 'https://www.mapbox.com/map-feedback/',
                context: context,
              ),
            ],
          ),
        ),
        buttonActions: [
          LmuDialogAction(
            title: context.locals.app.ok,
            onPressed: (context) => Navigator.of(context).pop(),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_4),
        child: SvgPicture.asset(
          'assets/mapbox_logo.svg',
          package: 'explore',
          height: LmuSizes.size_20,
          colorFilter: ColorFilter.mode(
            context.colors.neutralColors.textColors.weakColors.active ??
                context.colors.neutralColors.textColors.mediumColors.base,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

Widget _attributionLink({
  required String label,
  required String url,
  required BuildContext context,
}) {
  return LmuListItem.base(
    hasHorizontalPadding: false,
    hasVerticalPadding: false,
    subtitle: label,
    subtitleTextColor: context.colors.neutralColors.textColors.strongColors.base,
    trailingArea: Icon(
      LucideIcons.external_link,
      size: LmuIconSizes.mediumSmall,
      color: context.colors.neutralColors.textColors.mediumColors.base,
    ),
    onTap: () => LmuUrlLauncher.launchWebsite(
      url: url,
      context: context,
      mode: LmuUrlLauncherMode.inAppWebView,
    ),
  );
}
