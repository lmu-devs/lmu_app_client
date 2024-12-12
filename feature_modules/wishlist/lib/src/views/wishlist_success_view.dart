import 'dart:io';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import '../repository/api/api.dart';

class WishlistSuccessView extends StatelessWidget {
  const WishlistSuccessView({super.key, required this.wishlistModels});

  final List<WishlistModel> wishlistModels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LmuSizes.size_16,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: LmuSizes.size_12,
              ),
              child: LmuText.body(
                context.locals.wishlist.wishlistIntro,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
            ),
            const SizedBox(
              height: LmuSizes.size_16,
            ),
            LmuContentTile(
              content: [
                LmuListItem.action(
                  title: context.locals.wishlist.roadmapTitle,
                  subtitle: context.locals.wishlist.roadmapSubtitle,
                  mainContentAlignment: MainContentAlignment.center,
                  actionType: LmuListItemAction.chevron,
                  onTap: () {},
                ),
                LmuListItem.base(
                  title: context.locals.wishlist.betaTitle,
                  subtitle: context.locals.wishlist.betaSubtitle,
                  mainContentAlignment: MainContentAlignment.center,
                  trailingArea: LmuIcon(
                    size: LmuIconSizes.medium,
                    icon: LucideIcons.test_tube,
                    color: context.colors.neutralColors.textColors.weakColors.base,
                  ),
                  onTap: () {
                    LmuUrlLauncher.launchWebsite(
                      url: Platform.isIOS ? 'https://testflight.apple.com/join/JWEgpYxh' : '',
                      context: context,
                      mode: LmuUrlLauncherMode.inAppWebView,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: LmuSizes.size_16,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: wishlistModels.length,
              itemBuilder: (context, index) {
                final model = wishlistModels[index];
                return LmuText.body(
                  model.title,
                );
              },
            ),
            const SizedBox(
              height: LmuSizes.size_16,
            ),
            LmuContentTile(
              content: [
                LmuListItem.base(
                  title: context.locals.app.suggestFeature,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const LeadingFancyIcons(icon: LucideIcons.plus),
                  onTap: () {
                    GetIt.I.get<FeedbackService>().navigateToSuggestion(context);
                  },
                ),
                LmuListItem.base(
                  title: context.locals.app.reportBug,
                  mainContentAlignment: MainContentAlignment.center,
                  leadingArea: const LeadingFancyIcons(icon: LucideIcons.bug),
                  onTap: () {
                    GetIt.I.get<FeedbackService>().navigateToBugReport(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
