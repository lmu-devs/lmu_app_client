import 'dart:io';

import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_api/feedback.dart';

import '../bloc/wishlist_cubit.dart';
import '../bloc/wishlist_state.dart';
import '../widgets/wishlist_entry_list.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _feedbackApi = GetIt.I.get<FeedbackApi>();
  @override
  void initState() {
    final wishlistCubit = GetIt.I.get<WishlistCubit>();
    if (wishlistCubit.state is! WishlistLoadSuccess) {
      wishlistCubit.loadWishlistEntries();
    }

    super.initState();
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
    return LmuScaffold(
      appBar: LmuAppBarData(largeTitle: context.locals.wishlist.tabTitle),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: LmuSizes.size_16),
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
                  onTap: () => Share.share(LmuDevStrings.shareAppUrl),
                ),
                LmuButton(
                  title: context.locals.wishlist.rateApp,
                  emphasis: ButtonEmphasis.secondary,
                  onTap: () => GetIt.I.get<FeedbackApi>().openStoreListing(),
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
                    contentList: [
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
                  const SizedBox(height: LmuSizes.size_32),
                  LmuTileHeadline.base(title: context.locals.wishlist.wishlistEntriesTitle),
                  const WishlistEntryList(),
                  const SizedBox(height: LmuSizes.size_16),
                  LmuContentTile(
                    contentList: [
                      LmuListItem.base(
                        title: context.locals.app.suggestFeature,
                        mainContentAlignment: MainContentAlignment.center,
                        leadingArea: const LeadingFancyIcons(icon: LucideIcons.plus),
                        onTap: () => _feedbackApi.showFeedback(
                          context,
                          args: const FeedbackArgs(type: FeedbackType.suggestion, origin: 'WishlistScreen'),
                        ),
                      ),
                      LmuListItem.base(
                        title: context.locals.app.reportBug,
                        mainContentAlignment: MainContentAlignment.center,
                        leadingArea: const LeadingFancyIcons(icon: LucideIcons.bug),
                        onTap: () => _feedbackApi.showFeedback(
                          context,
                          args: const FeedbackArgs(type: FeedbackType.bug, origin: 'WishlistScreen'),
                        ),
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
