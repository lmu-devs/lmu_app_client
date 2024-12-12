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

import '../repository/api/api.dart';

class WishlistSuccessView extends StatelessWidget {
  const WishlistSuccessView({super.key, required this.wishlistModels});

  final List<WishlistModel> wishlistModels;

  Future<void> _requestAppReview() async {
    InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.openStoreListing();
    }
  }

  Future<void> _openInstagram(BuildContext context) async {
    const String instagramAppUrl = 'instagram://user?username=lmu.developers';
    const String instagramWebUrl = 'https://www.instagram.com/lmu.developers/';

    final bool isInstagramInstalled = await LmuUrlLauncher.canLaunch(
      url: instagramAppUrl,
    );

    final String urlToLaunch = isInstagramInstalled ? instagramAppUrl : instagramWebUrl;

    if (context.mounted) {
      LmuUrlLauncher.launchWebsite(
        context: context,
        url: urlToLaunch,
        mode: isInstagramInstalled ? LmuUrlLauncherMode.externalApplication : LmuUrlLauncherMode.platformDefault,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: LmuText.body(
              context.locals.wishlist.wishlistIntro,
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
          ),
          const SizedBox(height: LmuSizes.size_24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: LmuSizes.size_8,
                children: [
                  LmuButton(
                    title: context.locals.wishlist.shareApp,
                    onTap: () => Share.share('https://www.lmu-dev.org/'),
                  ),
                  LmuButton(
                    title: context.locals.wishlist.rateApp,
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () => _requestAppReview(),
                  ),
                  LmuButton(
                    title: context.locals.app.devTeam,
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () => LmuUrlLauncher.launchWebsite(
                      url: 'https://www.lmu-dev.org/',
                      context: context,
                      mode: LmuUrlLauncherMode.inAppWebView,
                    ),
                  ),
                  LmuButton(
                    title: context.locals.wishlist.instagram,
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () => _openInstagram(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: LmuSizes.size_24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: Column(
              children: [
                LmuContentTile(
                  content: [
                    LmuListItem.action(
                      title: context.locals.wishlist.betaTitle,
                      subtitle: context.locals.wishlist.betaSubtitle,
                      mainContentAlignment: MainContentAlignment.center,
                      actionType: LmuListItemAction.chevron,
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
                const SizedBox(height: LmuSizes.size_24),
                LmuTileHeadline.base(title: "New Features"),
                LmuContentTile(
                  content: wishlistModels
                      .map((model) => LmuListItem.base(
                            title: model.title,
                            titleInTextVisuals: [LmuInTextVisual.text(title: model.status)],
                            subtitle: model.description,
                            trailingSubtitle: model.ratingModel.likeCount.toString(),
                            mainContentAlignment: MainContentAlignment.center,
                          ))
                      .toList(),
                ),
                const SizedBox(height: LmuSizes.size_24),
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
                const SizedBox(height: LmuSizes.size_96),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
