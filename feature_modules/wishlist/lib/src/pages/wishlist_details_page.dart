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

  void _showImageView(BuildContext context, int clickedIndex) {
    ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(clickedIndex);

    PageController pageController = PageController(
      viewportFraction: 0.85,
      initialPage: clickedIndex,
    );

    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: context.colors.neutralColors.backgroundColors.base,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: LmuSizes.size_8,
                    left: LmuSizes.size_16,
                    right: LmuSizes.size_16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          LucideIcons.x,
                          size: LmuIconSizes.medium,
                        ),
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: currentIndexNotifier,
                        builder: (context, currentIndex, _) {
                          return LmuText(
                            '${currentIndex + 1} ${context.locals.wishlist.previewImageCount} ${wishlistModel.imageModels.length}',
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_32),
                    child: PageView.builder(
                      controller: pageController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: wishlistModel.imageModels.length,
                      onPageChanged: (int index) {
                        currentIndexNotifier.value = index;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: LmuSizes.size_16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
                            child: Image.network(
                              wishlistModel.imageModels.reversed.toList()[index].url,
                              fit: BoxFit.cover,
                              semanticLabel: wishlistModel.imageModels[index].name,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              height: 360,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
                controller: PageController(viewportFraction: (175 / MediaQuery.of(context).size.width)),
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
                          wishlistModel.imageModels.reversed.toList()[index].url,
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
