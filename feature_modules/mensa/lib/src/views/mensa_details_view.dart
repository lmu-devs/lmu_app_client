import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/mensa_menu_cubit/mensa_menu_cubit.dart';
import '../bloc/mensa_menu_cubit/mensa_menu_state.dart';
import '../repository/api/api.dart';
import '../repository/api/models/image_model.dart';
import 'views.dart';
import '../pages/pages.dart';
import '../services/services.dart';

class MensaDetailsView extends StatelessWidget {
  const MensaDetailsView({
    super.key,
    required this.mensaModel,
    required this.currentDayOfWeek,
  });

  final MensaModel mensaModel;
  final int currentDayOfWeek;

  @override
  Widget build(BuildContext context) {
    final openingHours = mensaModel.openingHours;

    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: mensaModel.images.isNotEmpty ? 210 : 0,
            pinned: true,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: context.colors.neutralColors.backgroundColors.base,
            flexibleSpace: FlexibleSpaceBar(
              background: ImageArea(images: mensaModel.images),
            ),
            leading: const SafeArea(
              child: Padding(
                padding: EdgeInsets.all(LmuSizes.medium),
                child: _DetailsBackButton(),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: LmuSizes.mediumLarge),
                child: LmuButton(
                  title: context.locals.canteen.myTaste,
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: LmuSizes.mediumLarge,
                right: LmuSizes.mediumLarge,
                top: LmuSizes.mediumSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: LmuSizes.medium,
                    ),
                    child: LmuText.h1(
                      mensaModel.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: LmuSizes.medium,
                    ),
                    child: LmuText.body(
                      mensaModel.location.address,
                      color: context.colors.neutralColors.textColors.mediumColors.base,
                    ),
                  ),
                  Divider(thickness: .5, height: 0, color: context.colors.neutralColors.borderColors.seperatorLight),
                  LmuListDropdown(
                    title: "Heute geöffnet bis ",
                    titleColor: Colors.green,
                    items: openingHours
                        .map((e) => LmuListItem.base(
                              title: e.day,
                              hasVerticalPadding: false,
                              hasHorizontalPadding: false,
                              trailingTitle:
                                  '${e.startTime.substring(0, e.startTime.length - 3)} - ${e.endTime.substring(0, e.endTime.length - 3)} Uhr',
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: LmuSizes.medium),
                  BlocBuilder<MensaMenuCubit, MensaMenuState>(
                    builder: (context, state) {
                      if (state is MensaMenuLoadInProgress) {
                        return const MensaMenuLoadingView();
                      } else if (state is MensaMenuLoadSuccess) {
                        return MensaMenuContentView(
                          mensaMenuModels: state.mensaMenuModels,
                          currentDayOfWeek: currentDayOfWeek,
                        );
                      }
                      return const MensaMenuErrorView();
                    },
                  ),
                  const SizedBox(height: LmuSizes.medium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsBackButton extends StatelessWidget {
  const _DetailsBackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.neutralColors.backgroundColors.tile,
        ),
        child: LmuIcon(
          icon: Icons.arrow_back,
          size: LmuIconSizes.medium,
          color: context.colors.neutralColors.textColors.strongColors.base,
        ),
      ),
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
    if (widget.images.isEmpty) {
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
