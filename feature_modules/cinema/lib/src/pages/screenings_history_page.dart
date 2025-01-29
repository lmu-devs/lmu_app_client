import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../repository/api/api.dart';
import '../util/screening_sorting.dart';
import '../widgets/screening_card.dart';

class ScreeningsHistoryPage extends StatefulWidget {
  const ScreeningsHistoryPage({
    super.key,
    required this.screenings,
  });

  final List<ScreeningModel> screenings;

  @override
  State<ScreeningsHistoryPage> createState() => _ScreeningsHistoryPageState();
}

class _ScreeningsHistoryPageState extends State<ScreeningsHistoryPage> {
  late ValueNotifier<SortOption> _sortOptionNotifier;
  late ValueNotifier<List<ScreeningModel>> _sortedScreeningsNotifier;

  @override
  void initState() {
    super.initState();
    _sortOptionNotifier = ValueNotifier(SortOption.recentFirst);
    _sortedScreeningsNotifier = ValueNotifier(
      _sortOptionNotifier.value.sort(widget.screenings),
    );
  }

  @override
  void dispose() {
    _sortOptionNotifier.dispose();
    _sortedScreeningsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.cinema;

    return LmuMasterAppBar(
      largeTitle: localizations.pastMoviesTitle,
      leadingAction: LeadingAction.back,
      body: widget.screenings.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<SortOption>(
                      valueListenable: _sortOptionNotifier,
                      builder: (context, activeSortOption, _) {
                        return LmuButton(
                          title: activeSortOption.title(localizations),
                          emphasis: ButtonEmphasis.secondary,
                          trailingIcon: LucideIcons.chevron_down,
                          onTap: () => _showSortOptionActionSheet(context),
                        );
                      },
                    ),
                    const SizedBox(height: LmuSizes.size_16),
                    ValueListenableBuilder<List<ScreeningModel>>(
                      valueListenable: _sortedScreeningsNotifier,
                      builder: (context, sortedScreenings, _) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          reverseDuration: const Duration(milliseconds: 50),
                          transitionBuilder: (child, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(begin: const Offset(0, .7), end: Offset.zero).animate(animation),
                              child: FadeTransition(opacity: animation, child: child),
                            );
                          },
                          child: ListView.builder(
                            key: ValueKey(sortedScreenings.map((screening) => screening.id).join()),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: sortedScreenings.length,
                            itemBuilder: (context, index) {
                              final screening = sortedScreenings[index];
                              return ScreeningCard(
                                screening: screening,
                                isLastItem: index == sortedScreenings.length - 1,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: LmuSizes.size_96),
                  ],
                ),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_32),
                child: LmuText.body(context.locals.cinema.pastMoviesEmpty, textAlign: TextAlign.center),
              ),
            ),
    );
  }

  void _showSortOptionActionSheet(BuildContext context) {
    LmuBottomSheet.show(
      context,
      content: _SortOptionActionSheetContent(
        sortOptionNotifier: _sortOptionNotifier,
        sortedScreeningsNotifier: _sortedScreeningsNotifier,
        screenings: widget.screenings,
      ),
    );
  }
}

class _SortOptionActionSheetContent extends StatelessWidget {
  const _SortOptionActionSheetContent({
    required this.sortOptionNotifier,
    required this.sortedScreeningsNotifier,
    required this.screenings,
  });

  final ValueNotifier<SortOption> sortOptionNotifier;
  final ValueNotifier<List<ScreeningModel>> sortedScreeningsNotifier;
  final List<ScreeningModel> screenings;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: SortOption.values.map((sortOption) {
        final isActive = sortOption == sortOptionNotifier.value;

        return LmuListItem.base(
          title: sortOption.title(context.locals.cinema),
          titleColor: isActive ? context.colors.brandColors.textColors.strongColors.base : null,
          leadingArea: LmuIcon(
            icon: sortOption.icon,
            size: LmuIconSizes.medium,
            color: isActive ? context.colors.brandColors.textColors.strongColors.base : null,
          ),
          onTap: () {
            sortOptionNotifier.value = sortOption;
            sortedScreeningsNotifier.value = sortOption.sort(screenings);
            Navigator.of(context).pop();
          },
        );
      }).toList(),
    );
  }
}
