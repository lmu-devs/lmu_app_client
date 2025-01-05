import 'dart:io';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:home/src/repository/api/models/home_model.dart';

class HomeSuccessView extends StatelessWidget {
  const HomeSuccessView({super.key, required this.homeData,});

  final HomeModel homeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.size_12),
          LmuContentTile(
            content: [
              LmuListItem.base(
                title: homeData.submissionFee,
                subtitle: context.locals.wishlist.betaSubtitle,
                mainContentAlignment: MainContentAlignment.center,
                trailingArea: LmuIcon(
                  icon: LucideIcons.external_link,
                  color:
                      context.colors.neutralColors.textColors.weakColors.base,
                  size: LmuIconSizes.mediumSmall,
                ),
                onTap: () {
                  LmuUrlLauncher.launchWebsite(
                    url: Platform.isIOS
                        ? LmuDevStrings.openBetaTestFlight
                        : LmuDevStrings.openBetaPlayStore,
                    context: context,
                    mode: LmuUrlLauncherMode.inAppWebView,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
