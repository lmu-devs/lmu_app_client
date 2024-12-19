import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';
import '../util/wishlist_status.dart';

class WishlistDetailsPage extends StatelessWidget {
  const WishlistDetailsPage({
    super.key,
    required this.wishlistModel,
  });

  final WishlistModel wishlistModel;

  Future<void> _launchPrototype(BuildContext context) async {
    if (await LmuUrlLauncher.canLaunch(url: wishlistModel.prototypeUrl)) {
      if (context.mounted) {
        LmuUrlLauncher.launchWebsite(
          url: wishlistModel.prototypeUrl,
          context: context,
          mode: LmuUrlLauncherMode.inAppWebView,
        );
      }
    } else {
      if (context.mounted) {
        LmuToast.show(
          context: context,
          type: ToastType.error,
          message: context.locals.wishlist.prototypeError,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: wishlistModel.title,
      leadingAction: LeadingAction.back,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      largeTitleTrailingWidget: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: LmuSizes.size_4,
        ),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.weakColors.active,
          borderRadius: BorderRadius.circular(
            LmuSizes.size_4,
          ),
        ),
        child: LmuText.bodySmall(wishlistModel.status.getValue(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  LmuButton(
                    leadingIcon: LucideIcons.heart,
                    title: "${wishlistModel.ratingModel.likeCount} Likes",
                    emphasis: ButtonEmphasis.secondary,
                  ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_24),
              LmuText.body(wishlistModel.description),
              const SizedBox(height: LmuSizes.size_24),
              SizedBox(
                height: 320,
                width: 160,
                child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: wishlistModel.imageModels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: LmuSizes.size_8),
                      child: GestureDetector(
                        onTap: () => {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
                          child: Container(
                            color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                            child: Image.network(
                              wishlistModel.imageModels[index].url,
                              fit: BoxFit.cover,
                              semanticLabel: wishlistModel.imageModels[index].name,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (wishlistModel.prototypeUrl.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: LmuSizes.size_24),
                    LmuButton(
                      size: ButtonSize.large,
                      showFullWidth: true,
                      title: context.locals.wishlist.testPrototype,
                      onTap: () => _launchPrototype(context),
                    ),
                  ],
                ),
              const SizedBox(height: LmuSizes.size_96),
            ],
          ),
        ),
      ),
    );
  }
}
