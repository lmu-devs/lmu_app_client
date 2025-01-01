import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  late ValueNotifier<Set<String>> _selectedPresetsNotifier;
  late Set<String> _initialExcludedLabels;

  late List<TasteProfileLabel> _sortedLabels;
  late List<TasteProfilePreset> _presets;

  final tasteProfileService = GetIt.I.get<TasteProfileService>();

  @override
  void initState() {
    super.initState();
    _isActiveNotifier = tasteProfileService.isActiveNotifier;
    _excludedLabelsNotifier = tasteProfileService.excludedLabelsNotifier;
    _selectedPresetsNotifier = tasteProfileService.selectedPresetsNotifier;
    _initialExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    final tasteProfile = (GetIt.I.get<TasteProfileCubit>().state as TasteProfileLoadSuccess).tasteProfile;
    _sortedLabels = tasteProfile.sortedLabels;
    _presets = tasteProfile.presets;
  }

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = Localizations.localeOf(context).languageCode.toUpperCase();

    return SliverStickyHeader(
      header: LmuTabBar(
        items: _sortedLabels.map((e) => LmuTabBarItemData(title: e.name)).toList(),
        activeTabIndexNotifier: ValueNotifier<int>(0),
        hasDivider: true,
        onTabChanged: (index, tabItem) {
          //itemScrollController.jumpTo(index: index);
        },
      ),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: ValueListenableBuilder(
            valueListenable: _excludedLabelsNotifier,
            builder: (context, excludedLabels, _) {
              return ScrollablePositionedList.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: LmuSizes.size_16),
                itemCount: _sortedLabels.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    SizedBox(height: index != _sortedLabels.length - 1 ? LmuSizes.size_16 : 0),
                itemBuilder: (context, index) {
                  final label = _sortedLabels[index];
                  return Column(
                    children: [
                      LmuContentTile(
                        content: [
                          for (final item in label.items)
                            LmuListItem.action(
                              title: item.text[selectedLanguage],
                              leadingArea: LmuText.body(
                                (item.emojiAbbreviation ?? "").isEmpty ? "😀" : item.emojiAbbreviation,
                              ),
                              actionType: LmuListItemAction.checkbox,
                              mainContentAlignment: MainContentAlignment.center,
                              initialValue: !excludedLabels.contains(item.enumName),
                              onChange: (value) {
                                final newExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);
                                final selectedPresets = Set<String>.from(_selectedPresetsNotifier.value);

                                if (value) {
                                  newExcludedLabels.remove(item.enumName);
                                } else {
                                  newExcludedLabels.add(item.enumName);
                                }

                                for (final preset in _presets) {
                                  final presetExclude = Set<String>.from(preset.exclude);
                                  final isPresetSelected = selectedPresets.contains(preset.enumName);
                                  final areAllPresetLabelsExcluded = newExcludedLabels.containsAll(presetExclude);

                                  if (isPresetSelected && !areAllPresetLabelsExcluded) {
                                    selectedPresets.remove(preset.enumName);
                                  } else if (!isPresetSelected && areAllPresetLabelsExcluded) {
                                    selectedPresets.add(preset.enumName);
                                  }
                                }

                                _selectedPresetsNotifier.value = selectedPresets;

                                _excludedLabelsNotifier.value = newExcludedLabels;
                                if (!setEquals(_initialExcludedLabels, newExcludedLabels)) {
                                  if (!_isActiveNotifier.value) _isActiveNotifier.value = true;
                                }
                              },
                            ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
