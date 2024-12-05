import 'package:core/constants.dart';
import 'package:core/src/core.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double height;

  const LmuImageCarousel({
    super.key,
    required this.imageUrls,
    this.height = 250,
  });

  @override
  State<LmuImageCarousel> createState() => _LmuImageCarouselState();
}

class _LmuImageCarouselState extends State<LmuImageCarousel> {
  late PageController _pageController;
  late ValueNotifier<int> _currentPageNotifier;

  @override
  void initState() {
    super.initState();
    _currentPageNotifier = ValueNotifier<int>(0);
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

  List<String> get imageUrls => widget.imageUrls;

  double get height => widget.height;

  @override
  Widget build(BuildContext context) {
    final nonInvertableColors = context.colors.neutralColors.textColors.nonInvertableColors;
    final enabledColor = nonInvertableColors.base;
    final disabledColor = nonInvertableColors.disabled;

    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    if (imageUrls.length == 1) {
      return SoftBlur(
        child: Image.network(
          imageUrls.first,
          height: height,
          fit: BoxFit.cover,
        ),
      );
    }

    return Stack(
      children: [
        SoftBlur(
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            clipBehavior: Clip.none,
            controller: _pageController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(
                imageUrls[index],
                height: height,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        Positioned(
          bottom: LmuSizes.size_12,
          left: 0,
          right: 0,
          child: Center(
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, currentPage, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    imageUrls.length,
                    (index) => GestureDetector(
                      onTap: () => _onDotTapped(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: LmuSizes.size_4,
                        ),
                        height: LmuSizes.size_8,
                        width: LmuSizes.size_8,
                        decoration: BoxDecoration(
                          color: currentPage == index ? enabledColor : disabledColor,
                          borderRadius: BorderRadius.circular(LmuSizes.size_8),
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
    );
  }
}
