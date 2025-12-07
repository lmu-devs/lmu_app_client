import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  late Set<String> _currentDegrees;
  late Set<String> _currentTypes;
  late Set<String> _currentLanguages;
  late Set<int> _currentSws;

  @override
  void initState() {
    super.initState();
    _currentDegrees = Set.from(widget.selectedDegrees);
    _currentTypes = Set.from(widget.selectedTypes);
    _currentLanguages = Set.from(widget.selectedLanguages);
    _currentSws = Set.from(widget.selectedSws);
  }

  bool get hasNoChanges {
    return setEquals(_currentDegrees, widget.selectedDegrees) &&
        setEquals(_currentTypes, widget.selectedTypes) &&
        setEquals(_currentLanguages, widget.selectedLanguages) &&
        setEquals(_currentSws, widget.selectedSws);
  }

  @override
  Widget build(BuildContext context) {
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
      onPopInvoked: () async => await _onPopInvoked(context),
      slivers: [
        _buildSectionTitle(context.locals.courses.degree),
        _buildCheckboxSection<String>(
          options: widget.availableDegrees,
          selectedValues: _currentDegrees,
          labelBuilder: (val) => val,
        ),
        _buildSectionTitle(context.locals.courses.courseType),
        _buildCheckboxSection<String>(
          options: widget.availableTypes,
          selectedValues: _currentTypes,
          labelBuilder: (val) => val,
        ),
        _buildSectionTitle(context.locals.courses.language),
        _buildCheckboxSection<String>(
          options: widget.availableLanguages,
          selectedValues: _currentLanguages,
          labelBuilder: (val) => val,
        ),
        _buildSectionTitle("SWS"),
        _buildCheckboxSection<int>(
          options: widget.availableSws,
          selectedValues: _currentSws,
          labelBuilder: (val) => val.toString(),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: LmuSizes.size_96)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: LmuSizes.size_16,
        top: LmuSizes.size_32,
        right: LmuSizes.size_16,
      ),
      sliver: SliverToBoxAdapter(
        child: LmuTileHeadline.base(title: title),
      ),
    );
  }

  Widget _buildCheckboxSection<T>({
    required List<T> options,
    required Set<T> selectedValues,
    required String Function(T) labelBuilder,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      sliver: SliverToBoxAdapter(
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
      ),
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
