import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../repository/api/models/taste_profile/taste_profile.dart';
import '../../services/taste_profile_service.dart';

class TasteProfilePresetsSection extends StatefulWidget {
  const TasteProfilePresetsSection({super.key, required this.tasteProfileModel});

  final TasteProfileModel tasteProfileModel;

  @override
  State<TasteProfilePresetsSection> createState() => _TasteProfilePresetsSectionState();
}

class _TasteProfilePresetsSectionState extends State<TasteProfilePresetsSection> {
  late final ValueNotifier<Set<String>> _selectedAllergiesPresetsNotifier;
  late final ValueNotifier<String?> _selectedPreferencePresetNotifier;
  late final ValueNotifier<bool> _isActiveNotifier;
  late final ValueNotifier<Set<String>> _excludedLabelsNotifier;
  late final List<TasteProfilePreset> _preferencesPresets;
  late final List<TasteProfilePreset> _allergiesPresets;

  TasteProfileModel get _tasteProfileModel => widget.tasteProfileModel;

  @override
  void initState() {
    final tasteProfleService = GetIt.I.get<TasteProfileService>();
    _selectedAllergiesPresetsNotifier = tasteProfleService.selectedAllergiesPresetsNotifier;
    _selectedPreferencePresetNotifier = tasteProfleService.selectedPreferencePresetNotifier;
    _isActiveNotifier = tasteProfleService.isActiveNotifier;
    _excludedLabelsNotifier = tasteProfleService.excludedLabelsNotifier;
    _preferencesPresets = _tasteProfileModel.preferencesPresets;
    _allergiesPresets = _tasteProfileModel.allergiesPresets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuTileHeadline.base(title: localizations.presets),
          ValueListenableBuilder(
            valueListenable: _selectedPreferencePresetNotifier,
            builder: (context, selectedPreferencePreset, _) {
              return LmuContentTile(
                contentList: _preferencesPresets.map(
                  (preferencesPreset) {
                    return LmuListItem.action(
                      title: preferencesPreset.text,
                      leadingArea: LmuText.body(preferencesPreset.emojiAbbreviation),
                      actionType: LmuListItemAction.radio,
                      mainContentAlignment: MainContentAlignment.center,
                      initialValue: selectedPreferencePreset?.contains(preferencesPreset.enumName),
                      shouldChange: (value) => !value,
                      onChange: (_) => _onPreferencesPresetChange(preferencesPreset),
                    );
                  },
                ).toList(),
              );
            },
          ),
          const SizedBox(height: LmuSizes.size_16),
          ValueListenableBuilder(
            valueListenable: _selectedAllergiesPresetsNotifier,
            builder: (context, selectedAllergiesPresets, _) {
              return LmuContentTile(
                contentList: _allergiesPresets.map(
                  (allergiesPreset) {
                    return LmuListItem.action(
                      title: allergiesPreset.text,
                      leadingArea: LmuText.body(allergiesPreset.emojiAbbreviation),
                      actionType: LmuListItemAction.checkbox,
                      mainContentAlignment: MainContentAlignment.center,
                      initialValue: selectedAllergiesPresets.contains(allergiesPreset.enumName),
                      onChange: (isActive) =>
                          _onAllergiesPresetChange(selectedAllergiesPresets, isActive, allergiesPreset),
                    );
                  },
                ).toList(),
              );
            },
          ),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }

  void _onPreferencesPresetChange(TasteProfilePreset preferencesPreset) {
    final presetName = preferencesPreset.enumName;
    final excludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    final otherLabels = _preferencesPresets
        .where((preset) => preset.enumName != presetName)
        .map((e) => e.exclude)
        .expand((element) => element)
        .toSet();

    final labelsFromToggle = _preferencesPresets.firstWhere((preset) => preset.enumName == presetName).exclude.toSet();

    excludedLabels.removeAll(otherLabels);
    excludedLabels.addAll(labelsFromToggle);
    if (_excludedLabelsNotifier.value != excludedLabels) {
      _excludedLabelsNotifier.value = excludedLabels;
      _isActiveNotifier.value = true;
    }
    _selectedPreferencePresetNotifier.value = preferencesPreset.enumName;
  }

  void _onAllergiesPresetChange(
      Set<String> selectedAllergiesPresets, bool isActive, TasteProfilePreset allergiesPreset) {
    final activeToggles = Set<String>.from(selectedAllergiesPresets);
    final excludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    final labelsFromToggles = activeToggles
        .map((e) => _allergiesPresets.firstWhere((element) => element.enumName == e).exclude)
        .expand((element) => element)
        .toSet();

    excludedLabels.removeAll(labelsFromToggles);

    if (isActive) {
      activeToggles.add(allergiesPreset.enumName);
    } else {
      activeToggles.remove(allergiesPreset.enumName);
    }

    for (final activeToggle in activeToggles) {
      final presetExclude = _allergiesPresets.firstWhere((element) => element.enumName == activeToggle).exclude;
      excludedLabels.addAll(presetExclude);
    }

    if (_excludedLabelsNotifier.value != excludedLabels) {
      _excludedLabelsNotifier.value = excludedLabels;
      _isActiveNotifier.value = true;
    }
    _selectedAllergiesPresetsNotifier.value = activeToggles;
  }
}
