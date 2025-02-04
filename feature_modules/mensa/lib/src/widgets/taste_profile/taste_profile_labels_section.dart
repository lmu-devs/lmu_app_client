import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/taste_profile/taste_profile_cubit.dart';
import '../../bloc/taste_profile/taste_profile_state.dart';
import '../../repository/api/models/taste_profile/taste_profile.dart';
import '../../services/taste_profile_service.dart';

class TasteProfileLabelsSection extends StatefulWidget {
  const TasteProfileLabelsSection({super.key});

  @override
  State<TasteProfileLabelsSection> createState() => _TasteProfileLabelsSectionState();
}

class _TasteProfileLabelsSectionState extends State<TasteProfileLabelsSection> {
  final tasteProfileService = GetIt.I.get<TasteProfileService>();

  late ValueNotifier<bool> _isActiveNotifier;
  late ValueNotifier<Set<String>> _excludedLabelsNotifier;
  late ValueNotifier<String?> _selectedPreferencePresetsNotifier;
  late ValueNotifier<Set<String>> _selectedAllergiesPresetsNotifier;
  late Set<String> _initialExcludedLabels;

  late ValueNotifier<int> _activeIndexNotifier;

  late List<TasteProfileLabel> _sortedLabels;
  late List<TasteProfilePreset> _preferencesPresets;
  late List<TasteProfilePreset> _allergiesPresets;
  late StickyHeaderController _stickyHeaderController;

  final _itemOffsets = <double>[];

  ScrollController? _primaryScrollController;
  double _stickyHeaderScrollOffset = 606;

  @override
  void initState() {
    super.initState();
    _isActiveNotifier = tasteProfileService.isActiveNotifier;
    _excludedLabelsNotifier = tasteProfileService.excludedLabelsNotifier;
    _selectedAllergiesPresetsNotifier = tasteProfileService.selectedAllergiesPresetsNotifier;
    _selectedPreferencePresetsNotifier = tasteProfileService.selectedPreferencePresetNotifier;
    _initialExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    _activeIndexNotifier = ValueNotifier<int>(0);
    _stickyHeaderController = StickyHeaderController();

    _stickyHeaderController.addListener(() {
      _stickyHeaderScrollOffset = _stickyHeaderController.stickyHeaderScrollOffset;
      _calculteCategoryOffsets();
    });

    final tasteProfile = (GetIt.I.get<TasteProfileCubit>().state as TasteProfileLoadSuccess).tasteProfile;
    _sortedLabels = tasteProfile.sortedLabels;
    _preferencesPresets = tasteProfile.preferencesPresets;
    _allergiesPresets = tasteProfile.allergiesPresets;

    _calculteCategoryOffsets();
  }

  void _calculteCategoryOffsets() {
    double currentOffset = _stickyHeaderScrollOffset;
    _itemOffsets.clear();
    for (int i = 0; i < _sortedLabels.length; i++) {
      _itemOffsets.add(currentOffset);
      final labelHeight = _calculateItemHeight(i);
      currentOffset += labelHeight + LmuSizes.size_16;
    }
  }

  double _calculateItemHeight(int index) {
    final label = _sortedLabels[index];
    final sortedLabelItems = label.items;
    const baseHeight = 8.0;
    final itemHeight = sortedLabelItems.length * 48.0;
    return baseHeight + itemHeight;
  }

  void _listenToScrollOffset() {
    final currentOffset = _primaryScrollController!.offset;
    if (_itemOffsets.isEmpty) return;
    final currentItem =
        _itemOffsets.lastIndexWhere((element) => element < currentOffset).clamp(0, _itemOffsets.length - 1);
    if (_activeIndexNotifier.value != currentItem) _activeIndexNotifier.value = currentItem;
  }

  @override
  Widget build(BuildContext context) {
    if (_primaryScrollController == null) {
      _primaryScrollController = PrimaryScrollController.of(context);
      _primaryScrollController!.addListener(_listenToScrollOffset);
    }

    return SliverStickyHeader(
      controller: _stickyHeaderController,
      header: LmuTabBar(
        items: _sortedLabels.map((e) => LmuTabBarItemData(title: e.name)).toList(),
        activeTabIndexNotifier: _activeIndexNotifier,
        hasDivider: true,
        onTabChanged: (index, tabItem) async {
          await _primaryScrollController!.animateTo(
            _itemOffsets[index] + 0.1,
            duration: const Duration(milliseconds: 500),
            curve: LmuAnimations.slowSmooth,
          );
        },
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        sliver: SliverList.separated(
          itemCount: _sortedLabels.length,
          separatorBuilder: (_, index) => SizedBox(height: index != _sortedLabels.length - 1 ? LmuSizes.size_16 : 0),
          itemBuilder: (context, index) {
            final label = _sortedLabels[index];
            final sortedLabelItems = label.items.toList()..sort((a, b) => a.text.compareTo(b.text));
            return LmuContentTile(
              key: GlobalObjectKey(label.name),
              content: [
                for (final item in sortedLabelItems)
                  ValueListenableBuilder(
                    valueListenable: _excludedLabelsNotifier,
                    builder: (context, excludedLabels, _) {
                      return LmuListItem.action(
                        title: item.text,
                        leadingArea: LmuText.body(
                          (item.emojiAbbreviation ?? "").isEmpty ? "🫙" : item.emojiAbbreviation,
                        ),
                        actionType: LmuListItemAction.checkbox,
                        mainContentAlignment: MainContentAlignment.center,
                        initialValue: !excludedLabels.contains(item.enumName),
                        onChange: (value) => _onToggleChange(value, item),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onToggleChange(bool value, TasteProfileLabelItem item) {
    final newExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    if (value) {
      newExcludedLabels.remove(item.enumName);
    } else {
      newExcludedLabels.add(item.enumName);
    }

    final selectedAllergiesPresets = Set<String>.from(_selectedAllergiesPresetsNotifier.value);
    for (final allergiesPreset in _allergiesPresets) {
      final presetExclude = Set<String>.from(allergiesPreset.exclude);
      final isPresetSelected = selectedAllergiesPresets.contains(allergiesPreset.enumName);
      final areAllPresetLabelsExcluded = newExcludedLabels.containsAll(presetExclude);

      if (isPresetSelected && !areAllPresetLabelsExcluded) {
        selectedAllergiesPresets.remove(allergiesPreset.enumName);
      } else if (!isPresetSelected && areAllPresetLabelsExcluded) {
        selectedAllergiesPresets.add(allergiesPreset.enumName);
      }
    }

    _selectedAllergiesPresetsNotifier.value = selectedAllergiesPresets;

    List<TasteProfilePreset> allExcludedPreferenceLabels = [];
    for (final preferencesPreset in _preferencesPresets) {
      final presetExclude = Set<String>.from(preferencesPreset.exclude);

      final areAllPresetLabelsExcluded = newExcludedLabels.containsAll(presetExclude);

      if (areAllPresetLabelsExcluded) {
        allExcludedPreferenceLabels.add(preferencesPreset);
      }
    }

    if (allExcludedPreferenceLabels.isNotEmpty) {
      allExcludedPreferenceLabels.sort((a, b) => b.exclude.length.compareTo(a.exclude.length));
      final newSelectedPreferencePreset = allExcludedPreferenceLabels.first.enumName;
      _selectedPreferencePresetsNotifier.value = newSelectedPreferencePreset;
    }

    _excludedLabelsNotifier.value = newExcludedLabels;
    if (!setEquals(_initialExcludedLabels, newExcludedLabels)) {
      if (!_isActiveNotifier.value) _isActiveNotifier.value = true;
    }
  }
}
