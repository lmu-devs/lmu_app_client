import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';
import '../util/wishlist_status.dart';
import '../widgets/image_preview_dialog.dart';

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

  void _showImageView(BuildContext context, int clickedIndex) {
    ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(clickedIndex);
    PageController pageController = PageController(viewportFraction: 0.85, initialPage: clickedIndex);

    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return ImagePreviewDialog(
          wishlistModel: wishlistModel,
          currentIndexNotifier: currentIndexNotifier,
          pageController: pageController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: wishlistModel.title,
      leadingAction: LeadingAction.back,
      largeTitleTrailingWidgetAlignment: MainAxisAlignment.start,
      largeTitleTrailingWidget: Container(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_4),
        decoration: BoxDecoration(
          color: context.colors.neutralColors.backgroundColors.weakColors.active,
          borderRadius: BorderRadius.circular(LmuRadiusSizes.small),
        ),
        child: LmuText.bodySmall(wishlistModel.status.getValue(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Row(
                children: [
                  LmuButton(
                    leadingIcon: LucideIcons.heart,
                    title: "${wishlistModel.ratingModel.likeCount} Likes",
                    emphasis: ButtonEmphasis.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: LmuSizes.size_24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: LmuText.body(wishlistModel.description),
            ),
            const SizedBox(height: LmuSizes.size_24),
            SizedBox(
              height: 375,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: wishlistModel.imageModels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? LmuSizes.size_16 : LmuSizes.none,
                      right: index == (wishlistModel.imageModels.length - 1) ? LmuSizes.size_16 : LmuSizes.size_8,
                    ),
                    child: GestureDetector(
                      onTap: () => _showImageView(context, index),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
                        child: Image.network(
                          wishlistModel.imageModels[index].url,
                          fit: BoxFit.cover,
                          semanticLabel: wishlistModel.imageModels[index].name,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (wishlistModel.prototypeUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: Column(
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
              ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}
