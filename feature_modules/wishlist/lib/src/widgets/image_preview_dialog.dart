import 'package:core/api.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';

class ImagePreviewDialog extends StatelessWidget {
  final List<ImageModel> imageModels;
  final ValueNotifier<int> currentIndexNotifier;
  final PageController pageController;

  const ImagePreviewDialog({
    super.key,
    required this.imageModels,
    required this.currentIndexNotifier,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 20) {
            Navigator.of(context).pop();
          }
        },
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          '${currentIndex + 1} ${context.locals.wishlist.previewImageCount} ${imageModels.length}',
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
                    itemCount:imageModels.length,
                    onPageChanged: (int index) {
                      currentIndexNotifier.value = index;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
                          child: Image.network(
                            imageModels[index].url,
                            fit: BoxFit.cover,
                            semanticLabel: imageModels[index].name,
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
      ),
    );
  }
}
