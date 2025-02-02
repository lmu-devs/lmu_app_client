import 'dart:io';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_api/feedback.dart';

import '../views/views.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  Future<void> _requestAppReview(BuildContext context) async {
    InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.openStoreListing(appStoreId: LmuDevStrings.appStoreId);
    } else {
      if (context.mounted) {
        LmuToast.show(
          context: context,
          message: context.locals.wishlist.rateAppError,
          type: ToastType.error,
        );
      }
    }
  }

  Future<void> _openInstagram(BuildContext context) async {
    final bool isInstagramInstalled = await LmuUrlLauncher.canLaunch(
      url: LmuDevStrings.instagramAppUrl,
    );

    if (context.mounted) {
      LmuUrlLauncher.launchWebsite(
        context: context,
        url: isInstagramInstalled ? LmuDevStrings.instagramAppUrl : LmuDevStrings.instagramWebUrl,
        mode: LmuUrlLauncherMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: context.locals.wishlist.tabTitle,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LmuSizes.size_12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: LmuText.body(
                context.locals.wishlist.wishlistIntro,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
            ),
            const SizedBox(height: LmuSizes.size_24),
            LmuButtonRow(
              buttons: [
                LmuButton(
                  title: context.locals.wishlist.shareApp,
                  onTap: () => Share.share(LmuDevStrings.lmuDevWebsite),
                ),
                LmuButton(
                  title: context.locals.wishlist.rateApp,
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () => _requestAppReview(context),
                ),
                LmuButton(
                  title: LmuDevStrings.devTeam,
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () => LmuUrlLauncher.launchWebsite(
                    url: LmuDevStrings.lmuDevWebsite,
                    context: context,
                    mode: LmuUrlLauncherMode.inAppWebView,
                  ),
                ),
                LmuButton(
                  title: 'Instagram',
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () => _openInstagram(context),
                ),
                LmuButton(
                  title: 'LinkedIn',
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () => LmuUrlLauncher.launchWebsite(
                    url: LmuDevStrings.linkedinWebUrl,
                    context: context,
                    mode: LmuUrlLauncherMode.externalApplication,
                  ),
                ),
              ],
            ),
            const SizedBox(height: LmuSizes.size_24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  LmuContentTile(
                    content: [
                      LmuListItem.base(
                        title: context.locals.wishlist.betaTitle,
                        subtitle: context.locals.wishlist.betaSubtitle,
                        mainContentAlignment: MainContentAlignment.center,
                        trailingArea: LmuIcon(
                          icon: LucideIcons.external_link,
                          color: context.colors.neutralColors.textColors.weakColors.base,
                          size: LmuIconSizes.mediumSmall,
                        ),
                        onTap: () {
                          LmuUrlLauncher.launchWebsite(
                            url: Platform.isIOS ? LmuDevStrings.openBetaTestFlight : LmuDevStrings.openBetaPlayStore,
                            context: context,
                            mode: LmuUrlLauncherMode.inAppWebView,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: LmuSizes.size_24),
                  const WishlistEntryView(),
                  LmuContentTile(
                    content: [
                      LmuListItem.base(
                        title: context.locals.app.suggestFeature,
                        mainContentAlignment: MainContentAlignment.center,
                        leadingArea: const LeadingFancyIcons(icon: LucideIcons.plus),
                        onTap: () {
                          GetIt.I.get<FeedbackService>().navigateToSuggestion(context, 'WishlistScreen');
                        },
                      ),
                      LmuListItem.base(
                        title: context.locals.app.reportBug,
                        mainContentAlignment: MainContentAlignment.center,
                        leadingArea: const LeadingFancyIcons(icon: LucideIcons.bug),
                        onTap: () {
                          GetIt.I.get<FeedbackService>().navigateToBugReport(context, 'WishlistScreen');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: LmuSizes.size_96),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
