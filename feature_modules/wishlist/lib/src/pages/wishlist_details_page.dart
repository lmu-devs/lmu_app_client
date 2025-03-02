import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/extensions.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import '../repository/api/api.dart';
import '../services/services.dart';
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
        ).whenComplete(
          () => GetIt.I.get<FeedbackService>().navigateToFeedback(
                context,
                'Wishlist Entry: ${wishlistModel.title}',
              ),
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
      largeTitleTrailingWidget: wishlistModel.status != WishlistStatus.none
          ? LmuInTextVisual.text(
              title: wishlistModel.status.getValue(context),
              textColor: context.colors.neutralColors.textColors.strongColors.base,
              size: InTextVisualSize.large,
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: LmuSizes.size_8,
                  children: [
                    ValueListenableBuilder<List<String>>(
                      valueListenable: GetIt.I<WishlistUserPreferenceService>().likedWishlistIdsNotifier,
                      builder: (context, likedWishlistIds, child) {
                        final isLiked = likedWishlistIds.contains(wishlistModel.id.toString());
                        final calculatedLikes = wishlistModel.ratingModel.calculateLikeCount(isLiked);

                        return LmuButton(
                          leadingWidget: StarIcon(
                            key: ValueKey(wishlistModel.id),
                            isActive: isLiked,
                            disabledColor: context.colors.neutralColors.backgroundColors.mediumColors.active,
                          ),
                          title: "$calculatedLikes Likes",
                          emphasis: ButtonEmphasis.secondary,
                          onTap: () async {
                            await GetIt.I<WishlistUserPreferenceService>()
                                .toggleLikedWishlistId(wishlistModel.id.toString());
                            LmuVibrations.secondary();
                          },
                        );
                      },
                    ),
                    LmuButton(
                      title: context.locals.feedback.feedbackButton,
                      emphasis: ButtonEmphasis.secondary,
                      onTap: () => GetIt.I
                          .get<FeedbackService>()
                          .navigateToFeedback(context, 'Wishlist Entry: ${wishlistModel.title}'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: LmuSizes.size_24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: LmuText.body(
                wishlistModel.description,
                color: context.colors.neutralColors.textColors.mediumColors.base,
              ),
            ),
            const SizedBox(height: LmuSizes.size_24),
            ImageListSection(imageModels: wishlistModel.imageModels),
            if (wishlistModel.prototypeUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  top: LmuSizes.size_24,
                  left: LmuSizes.size_16,
                  right: LmuSizes.size_16,
                ),
                child: LmuButton(
                  size: ButtonSize.large,
                  showFullWidth: true,
                  title: context.locals.wishlist.testPrototype,
                  onTap: () => _launchPrototype(context),
                ),
              ),
            const SizedBox(height: LmuSizes.size_96),
          ],
        ),
      ),
    );
  }
}

class ImageListSection extends StatelessWidget {
  const ImageListSection({super.key, required this.imageModels});

  final List<ImageModel> imageModels;

  void _showImageView(BuildContext context, int clickedIndex) {
    ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(clickedIndex);
    PageController pageController = PageController(viewportFraction: 0.85, initialPage: clickedIndex);

    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return ImagePreviewDialog(
          imageModels: imageModels,
          currentIndexNotifier: currentIndexNotifier,
          pageController: pageController,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 375,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageModels.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? LmuSizes.size_16 : LmuSizes.none,
              right: index == (imageModels.length - 1) ? LmuSizes.size_16 : LmuSizes.size_8,
            ),
            child: GestureDetector(
              onTap: () => _showImageView(context, index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
                child: FutureBuilder(
                  future: precacheImage(NetworkImage(imageModels[index].url), context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Image.network(
                        imageModels[index].url,
                        fit: BoxFit.cover,
                        width: 175,
                        semanticLabel: imageModels[index].name,
                      );
                    } else {
                      return LmuSkeleton(
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
