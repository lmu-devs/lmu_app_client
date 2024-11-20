import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../../pages/pages.dart';
import '../../pages/taste_profile_page.dart';
import '../../repository/api/api.dart';
import '../../repository/api/models/mensa/image_model.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class MensaDetailsContentView extends StatelessWidget {
  const MensaDetailsContentView({
    super.key,
    required this.mensaModel,
    required this.currentDayOfWeek,
  });

  final MensaModel mensaModel;
  final int currentDayOfWeek;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final localizations = context.locals.canteen;

    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      body: CustomScrollView(
        slivers: [
          _AppBarWithImage(mensaModel: mensaModel, colors: colors, localizations: localizations),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MensaDetailsInfoSection(mensaModel: mensaModel),
                const MensaDetailsMenuSection(),
                const SizedBox(height: LmuSizes.medium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarWithImage extends StatelessWidget {
  const _AppBarWithImage({
    required this.mensaModel,
    required this.colors,
    required this.localizations,
  });

  final MensaModel mensaModel;
  final LmuColors colors;
  final CanteenLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: mensaModel.images.isNotEmpty ? 210 : 0,
      pinned: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: colors.neutralColors.backgroundColors.base,
      flexibleSpace: FlexibleSpaceBar(
        background: ImageArea(images: mensaModel.images),
      ),
      leading: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: LmuSizes.medium, top: LmuSizes.medium, bottom: LmuSizes.xsmall),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: LmuSizes.large,
              height: LmuSizes.large,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.neutralColors.backgroundColors.tile,
              ),
              child: LmuIcon(
                icon: LucideIcons.arrow_left,
                size: LmuIconSizes.medium,
                color: context.colors.neutralColors.textColors.strongColors.base,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: LmuSizes.mediumLarge),
          child: LmuButton(
            title: localizations.myTaste,
            emphasis: ButtonEmphasis.secondary,
            onTap: () async {
              final tasteProfileService = GetIt.I.get<TasteProfileService>();
              final saveModel = await tasteProfileService.loadTasteProfileState();
              if (context.mounted) {
                LmuBottomSheet.showExtended(
                  context,
                  content: TasteProfilePage(
                    selectedPresets: saveModel.selectedPresets,
                    excludedLabels: saveModel.excludedLabels,
                    isActive: saveModel.isActive,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class ImageArea extends StatefulWidget {
  final List<ImageModel> images;

  const ImageArea({super.key, required this.images});

  @override
  ImageAreaState createState() => ImageAreaState();
}

class ImageAreaState extends State<ImageArea> {
  late PageController _pageController;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      int page = _pageController.page?.round() ?? 0;
      if (_currentPageNotifier.value != page) {
        _currentPageNotifier.value = page;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _currentPageNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    if (images.isEmpty) {
      return const SizedBox.shrink();
    } else if (widget.images.length == 1) {
      return SoftBlur(
        child: Image.network(
          widget.images.first.url!,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SoftBlur(
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              clipBehavior: Clip.none,
              controller: _pageController,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.images[index].url!,
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned(
              bottom: LmuSizes.medium,
              left: 0,
              right: 0,
              child: Center(
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, currentPage, child) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        widget.images.length,
                        (index) => GestureDetector(
                          onTap: () => _onDotTapped(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: LmuSizes.small,
                            ),
                            height: LmuSizes.mediumSmall,
                            width: LmuSizes.mediumSmall,
                            decoration: BoxDecoration(
                              color: currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
