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
import '../routes/routes.dart';
import '../util/wishlist_status.dart';

class WishlistSuccessView extends StatelessWidget {
  const WishlistSuccessView({super.key, required this.wishlistModels});

  final List<WishlistModel> wishlistModels;

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
    final publicWishlistModels = wishlistModels.where((model) => model.status != WishlistStatus.hidden).toList()
      ..sort((a, b) {
        const statusOrder = {
          WishlistStatus.beta: 0,
          WishlistStatus.development: 1,
          WishlistStatus.none: 2,
          WishlistStatus.done: 3,
        };

        return statusOrder[a.status]!.compareTo(statusOrder[b.status]!);
      });

    return SingleChildScrollView(
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
                          url: Platform.isIOS ? LmuDevStrings.openBetaTestFlight : LmuDevStrings.openBetaPlayStore,
                          context: context,
                          mode: LmuUrlLauncherMode.inAppWebView,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: LmuSizes.size_24),
                if (publicWishlistModels.isNotEmpty)
                  Column(
                    children: [
                      LmuTileHeadline.base(title: context.locals.wishlist.wishlistEntriesTitle),
                      LmuContentTile(
                        content: publicWishlistModels
                            .map(
                              (wishlistModel) => LmuListItem.action(
                                title: wishlistModel.title,
                                titleInTextVisuals: wishlistModel.status.getValue(context).isNotEmpty
                                    ? [LmuInTextVisual.text(title: wishlistModel.status.getValue(context))]
                                    : [],
                                subtitle: wishlistModel.descriptionShort,
                                trailingTitle: wishlistModel.ratingModel.likeCount.toString(),
                                maximizeLeadingTitleArea: true,
                                actionType: LmuListItemAction.chevron,
                                onTap: () => WishlistDetailsRoute(wishlistModel).go(context),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: LmuSizes.size_24),
                    ],
                  ),
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
    );
  }
}
