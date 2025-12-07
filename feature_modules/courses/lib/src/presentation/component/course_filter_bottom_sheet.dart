import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class CourseFilterBottomSheet extends StatefulWidget {
  const CourseFilterBottomSheet({
    super.key,
    required this.availableDegrees,
    required this.availableTypes,
    required this.availableLanguages,
    required this.availableSws,
    required this.selectedDegrees,
    required this.selectedTypes,
    required this.selectedLanguages,
    required this.selectedSws,
    required this.onApply,
  });

  final List<String> availableDegrees;
  final List<String> availableTypes;
  final List<String> availableLanguages;
  final List<int> availableSws;

  final Set<String> selectedDegrees;
  final Set<String> selectedTypes;
  final Set<String> selectedLanguages;
  final Set<int> selectedSws;

  final void Function(
    Set<String> degrees,
    Set<String> types,
    Set<String> languages,
    Set<int> sws,
  ) onApply;

  @override
  State<CourseFilterBottomSheet> createState() =>
      _CourseFilterBottomSheetState();
}

class _CourseFilterBottomSheetState extends State<CourseFilterBottomSheet> {
  ScrollController? _scrollController;
  late final ListController _listController;
  late ValueNotifier<int> _activeIndexNotifier;

  late Set<String> _currentDegrees;
  late Set<String> _currentTypes;
  late Set<String> _currentLanguages;
  late Set<int> _currentSws;

  @override
  void initState() {
    super.initState();

    _listController = ListController();
    _listController.addListener(_onListControllerValue);
    _activeIndexNotifier = ValueNotifier<int>(0);

    _currentDegrees = Set.from(widget.selectedDegrees);
    _currentTypes = Set.from(widget.selectedTypes);
    _currentLanguages = Set.from(widget.selectedLanguages);
    _currentSws = Set.from(widget.selectedSws);
  }

  List<String> get _categories {
    final locals = context.locals.courses;
    return [
      locals.degree,
      locals.courseType,
      locals.language,
      "SWS",
    ];
  }

  void _resetFilters() {
    setState(() {
      _currentDegrees.clear();
      _currentTypes.clear();
      _currentLanguages.clear();
      _currentSws.clear();
    });
  }

  bool get hasNoChanges {
    return setEquals(_currentDegrees, widget.selectedDegrees) &&
        setEquals(_currentTypes, widget.selectedTypes) &&
        setEquals(_currentLanguages, widget.selectedLanguages) &&
        setEquals(_currentSws, widget.selectedSws);
  }

  @override
  void dispose() {
    _listController.removeListener(_onListControllerValue);
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = context.modalScrollController;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: context.locals.courses.courseFilterTitle,
        trailingWidgets: [
          LmuButton(
            title: context.locals.courses.applyFilter,
            emphasis: ButtonEmphasis.link,
            size: ButtonSize.large,
            increaseTouchTarget: true,
            textScaleFactorEnabled: false,
            onTap: () {
              widget.onApply(
                _currentDegrees,
                _currentTypes,
                _currentLanguages,
                _currentSws,
              );
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
        leadingAction: LeadingAction.close,
        onLeadingActionTap: () => _onLeadingClose(context),
      ),
      isBottomSheet: true,
      customScrollController: _scrollController,
      onPopInvoked: () async => await _onPopInvoked(context),
      slivers: [
        _buildDescriptionSection(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
            child: LmuTileHeadline.action(
              title: context.locals.courses.courseFilterCategories,
              actionTitle: context.locals.app.reset,
              onActionTap: () => _resetFilters(),
            ),
          ),
        ),
        PinnedHeaderSliver(
          child: LmuTabBar(
            activeTabIndexNotifier: _activeIndexNotifier,
            items: _categories
                .map((category) => LmuTabBarItemData(title: category))
                .toList(),
            hasDivider: true,
            onTabChanged: (index, tabItem) => _animateToItem(index),
          ),
        ),
        SuperSliverList.builder(
          itemCount: _categories.length,
          listController: _listController,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Column(
                  children: [
                    _buildSectionTitle(context.locals.courses.degree),
                    _buildCheckboxSection<String>(
                      options: widget.availableDegrees,
                      selectedValues: _currentDegrees,
                      labelBuilder: (val) => val,
                    ),
                  ],
                );
              case 1:
                return Column(
                  children: [
                    _buildSectionTitle(context.locals.courses.courseType),
                    _buildCheckboxSection<String>(
                      options: widget.availableTypes,
                      selectedValues: _currentTypes,
                      labelBuilder: (val) => val,
                    ),
                  ],
                );
              case 2:
                return Column(
                  children: [
                    _buildSectionTitle(context.locals.courses.language),
                    _buildCheckboxSection<String>(
                      options: widget.availableLanguages,
                      selectedValues: _currentLanguages,
                      labelBuilder: (val) => val,
                    ),
                  ],
                );
              case 3:
                return Column(
                  children: [
                    _buildSectionTitle("SWS"),
                    _buildCheckboxSection<int>(
                      options: widget.availableSws,
                      selectedValues: _currentSws,
                      labelBuilder: (val) => val.toString(),
                    ),
                  ],
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
        _buildFooterSection(),
        const SliverToBoxAdapter(child: SizedBox(height: LmuSizes.size_96)),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return SliverPadding(
      padding: const EdgeInsets.only(
          top: LmuSizes.size_8,
          left: LmuSizes.size_16,
          right: LmuSizes.size_16,
          bottom: LmuSizes.size_32),
      sliver: SliverToBoxAdapter(
        child: LmuText.body(
          context.locals.courses.courseFilterDescription,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: LmuSizes.size_16,
        top: LmuSizes.size_32,
        right: LmuSizes.size_16,
      ),
      child: LmuTileHeadline.base(title: title),
    );
  }

  Widget _buildCheckboxSection<T>({
    required List<T> options,
    required Set<T> selectedValues,
    required String Function(T) labelBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: LmuContentTile(
        contentList: options.asMap().entries.map((entry) {
          final int index = entry.key;
          final T option = entry.value;
          final bool isSelected = selectedValues.contains(option);
          final String label = labelBuilder(option);

          final activeColor =
              context.colors.brandColors.textColors.strongColors.base;
          final inactiveColor =
              context.colors.neutralColors.textColors.mediumColors.base;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LmuListItem.action(
                key: ValueKey(option),
                actionType: LmuListItemAction.checkbox,
                title: label,
                titleColor: isSelected ? activeColor : inactiveColor,
                initialValue: isSelected,
                onChange: (bool newValue) {
                  setState(() {
                    if (newValue) {
                      selectedValues.add(option);
                    } else {
                      selectedValues.remove(option);
                    }
                  });
                },
              ),
              if (index != options.length - 1)
                const SizedBox(height: LmuSizes.size_4),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFooterSection() {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: LmuSizes.size_32,
        left: LmuSizes.size_16,
        right: LmuSizes.size_16,
      ),
      sliver: SliverToBoxAdapter(
        child: LmuText.body(
          context.locals.courses.courseFilterFooter,
          color: context.colors.neutralColors.textColors.mediumColors.base,
        ),
      ),
    );
  }

  void _onListControllerValue() {
    final visibleStart = _listController.unobstructedVisibleRange?.$1 ?? 0;
    if (_activeIndexNotifier.value != visibleStart) {
      _activeIndexNotifier.value = visibleStart;
    }
  }

  void _animateToItem(int index) {
    _listController.animateToItem(
      index: index,
      scrollController: _scrollController!,
      alignment: 0,
      duration: (estimatedDistance) => const Duration(milliseconds: 500),
      curve: (estimatedDistance) => LmuAnimations.slowSmooth,
    );
  }

  Future<bool> _onPopInvoked(BuildContext context) async {
    if (hasNoChanges) return true;

    bool shouldClose = false;
    await _showUnsavedChangesDialog(
      context,
      onDiscardPressed: () => shouldClose = true,
      onContinuePressed: () => shouldClose = false,
    );

    return shouldClose;
  }

  void _onLeadingClose(BuildContext context) async {
    final sheetNavigator = Navigator.of(context, rootNavigator: true);

    if (hasNoChanges) {
      sheetNavigator.pop();
      return;
    }

    _showUnsavedChangesDialog(context,
        onDiscardPressed: () => sheetNavigator.pop());
  }

  Future<void> _showUnsavedChangesDialog(
    BuildContext context, {
    required void Function() onDiscardPressed,
    void Function()? onContinuePressed,
  }) async {
    final appLocals = context.locals.app;
    await LmuDialog.show(
      context: context,
      title: appLocals.unsavedChanges,
      description: appLocals.unsavedChangesDescription,
      buttonActions: [
        LmuDialogAction(
          title: appLocals.discard,
          isSecondary: true,
          onPressed: (context) {
            onDiscardPressed();
            Navigator.of(context).pop();
          },
        ),
        LmuDialogAction(
          title: appLocals.continueAction,
          onPressed: (context) {
            Navigator.of(context).pop();
            onContinuePressed?.call();
          },
        ),
      ],
    );
  }
}
