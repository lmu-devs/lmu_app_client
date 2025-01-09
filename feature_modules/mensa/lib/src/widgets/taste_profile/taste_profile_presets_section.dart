import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/taste_profile/taste_profile_cubit.dart';
import '../../bloc/taste_profile/taste_profile_state.dart';
import '../../services/taste_profile_service.dart';

class TasteProfilePresetsSection extends StatelessWidget {
  const TasteProfilePresetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAllergiesPresetsNotifier = GetIt.I.get<TasteProfileService>().selectedAllergiesPresetsNotifier;
    final selectedPreferencePresetNotifier = GetIt.I.get<TasteProfileService>().selectedPreferencePresetNotifier;
    final isActiveNotifier = GetIt.I.get<TasteProfileService>().isActiveNotifier;
    final excludedLabelsNotifier = GetIt.I.get<TasteProfileService>().excludedLabelsNotifier;
    final localizations = context.locals.canteen;
    final tasteProfile = (GetIt.I.get<TasteProfileCubit>().state as TasteProfileLoadSuccess).tasteProfile;
    final preferencesPresets = tasteProfile.preferencesPresets;
    final allergiesPresets = tasteProfile.allergiesPresets;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuTileHeadline.base(title: localizations.presets),
          ValueListenableBuilder(
            valueListenable: selectedPreferencePresetNotifier,
            builder: (context, selectedPreferencePreset, _) {
              return LmuContentTile(
                content: [
                  for (final preferencesPreset in preferencesPresets)
                    LmuListItem.action(
                      title: preferencesPreset.text,
                      leadingArea: LmuText.body(preferencesPreset.emojiAbbreviation),
                      actionType: LmuListItemAction.radio,
                      mainContentAlignment: MainContentAlignment.center,
                      initialValue: selectedPreferencePreset?.contains(preferencesPreset.enumName),
                      shouldChange: (value) => !value,
                      onChange: (value) {
                        final excludedLabels = Set<String>.from(excludedLabelsNotifier.value);
                        final presetName = preferencesPreset.enumName;

                        final otherLabels = preferencesPresets
                            .where((element) => element.enumName != presetName)
                            .map((e) => e.exclude)
                            .expand((element) => element)
                            .toSet();

                        final labelsFromToggle =
                            preferencesPresets.firstWhere((element) => element.enumName == presetName).exclude.toSet();

                        excludedLabels.removeAll(otherLabels);

                        excludedLabels.addAll(labelsFromToggle);

                        if (excludedLabelsNotifier.value != excludedLabels) {
                          excludedLabelsNotifier.value = excludedLabels;
                          isActiveNotifier.value = true;
                        }

                        selectedPreferencePresetNotifier.value = preferencesPreset.enumName;
                      },
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: LmuSizes.size_16),
          ValueListenableBuilder(
            valueListenable: selectedAllergiesPresetsNotifier,
            builder: (context, selectedAllergiesPresets, _) {
              return LmuContentTile(
                content: [
                  for (final allergiesPreset in allergiesPresets)
                    LmuListItem.action(
                      title: allergiesPreset.text,
                      leadingArea: LmuText.body(allergiesPreset.emojiAbbreviation),
                      actionType: LmuListItemAction.checkbox,
                      mainContentAlignment: MainContentAlignment.center,
                      initialValue: selectedAllergiesPresets.contains(allergiesPreset.enumName),
                      onChange: (value) {
                        final activeToggles = Set<String>.from(selectedAllergiesPresets);
                        final excludedLabels = Set<String>.from(excludedLabelsNotifier.value);

                        final labelsFromToggles = activeToggles
                            .map((e) => allergiesPresets.firstWhere((element) => element.enumName == e).exclude)
                            .expand((element) => element)
                            .toSet();

                        excludedLabels.removeAll(labelsFromToggles);

                        if (value) {
                          activeToggles.add(allergiesPreset.enumName);
                        } else {
                          activeToggles.remove(allergiesPreset.enumName);
                        }

                        for (final activeToggle in activeToggles) {
                          final presetExclude =
                              allergiesPresets.firstWhere((element) => element.enumName == activeToggle).exclude;
                          excludedLabels.addAll(presetExclude);
                        }

                        if (excludedLabelsNotifier.value != excludedLabels) {
                          excludedLabelsNotifier.value = excludedLabels;
                          isActiveNotifier.value = true;
                        }
                        selectedAllergiesPresetsNotifier.value = activeToggles;
                      },
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }
}
