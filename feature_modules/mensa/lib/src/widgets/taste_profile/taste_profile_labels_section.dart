import 'package:core/components.dart';
import 'package:core/constants.dart';
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
  late ValueNotifier<bool> _isActiveNotifier;
  late ValueNotifier<Set<String>> _excludedLabelsNotifier;
  late ValueNotifier<String?> _selectedPreferencePresetsNotifier;
  late ValueNotifier<Set<String>> _selectedAllergiesPresetsNotifier;
  late Set<String> _initialExcludedLabels;

  late List<TasteProfileLabel> _sortedLabels;
  late List<TasteProfilePreset> _preferencesPresets;
  late List<TasteProfilePreset> _allergiesPresets;

  final tasteProfileService = GetIt.I.get<TasteProfileService>();
  @override
  void initState() {
    super.initState();
    _isActiveNotifier = tasteProfileService.isActiveNotifier;
    _excludedLabelsNotifier = tasteProfileService.excludedLabelsNotifier;
    _selectedAllergiesPresetsNotifier = tasteProfileService.selectedAllergiesPresetsNotifier;
    _selectedPreferencePresetsNotifier = tasteProfileService.selectedPreferencePresetNotifier;
    _initialExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    final tasteProfile = (GetIt.I.get<TasteProfileCubit>().state as TasteProfileLoadSuccess).tasteProfile;
    _sortedLabels = tasteProfile.sortedLabels;
    _preferencesPresets = tasteProfile.preferencesPresets;
    _allergiesPresets = tasteProfile.allergiesPresets;
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: LmuTabBar(
        items: _sortedLabels.map((e) => LmuTabBarItemData(title: e.name)).toList(),
        activeTabIndexNotifier: ValueNotifier<int>(0),
        hasDivider: true,
        onTabChanged: (index, tabItem) {
          //.of(context).position.
        },
      ),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: LmuSizes.size_16),
            itemCount: _sortedLabels.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) =>
                SizedBox(height: index != _sortedLabels.length - 1 ? LmuSizes.size_16 : 0),
            itemBuilder: (context, index) {
              final label = _sortedLabels[index];
              final sortedLabelItems = label.items.toList()..sort((a, b) => a.text.compareTo(b.text));
              return Column(
                children: [
                  LmuContentTile(
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
                              onChange: (value) {
                                final newExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

                                if (value) {
                                  newExcludedLabels.remove(item.enumName);
                                } else {
                                  newExcludedLabels.add(item.enumName);
                                }

                                final selectedAllergiesPresets =
                                    Set<String>.from(_selectedAllergiesPresetsNotifier.value);
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
                                  allExcludedPreferenceLabels
                                      .sort((a, b) => b.exclude.length.compareTo(a.exclude.length));
                                  final newSelectedPreferencePreset = allExcludedPreferenceLabels.first.enumName;
                                  _selectedPreferencePresetsNotifier.value = newSelectedPreferencePreset;
                                }

                                _excludedLabelsNotifier.value = newExcludedLabels;
                                if (!setEquals(_initialExcludedLabels, newExcludedLabels)) {
                                  if (!_isActiveNotifier.value) _isActiveNotifier.value = true;
                                }
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
