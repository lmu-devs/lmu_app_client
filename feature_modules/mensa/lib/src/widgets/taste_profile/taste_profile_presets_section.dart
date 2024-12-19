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
    final selectedPresetNotifier = GetIt.I.get<TasteProfileService>().selectedPresetsNotifier;
    final excludedLabelsNotifier = GetIt.I.get<TasteProfileService>().excludedLabelsNotifier;
    final localizations = context.locals.canteen;
    final selectedLanguage = Localizations.localeOf(context).languageCode.toUpperCase();
    final tasteProfile = (GetIt.I.get<TasteProfileCubit>().state as TasteProfileLoadSuccess).tasteProfile;
    final presets = tasteProfile.presets;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuTileHeadline.base(title: localizations.presets),
          ValueListenableBuilder(
            valueListenable: selectedPresetNotifier,
            builder: (context, selectedPresets, _) {
              return LmuContentTile(
                content: [
                  for (final preset in presets)
                    LmuListItem.action(
                      title: preset.text[selectedLanguage],
                      leadingArea: LmuText.body(preset.emojiAbbreviation),
                      actionType: LmuListItemAction.toggle,
                      mainContentAlignment: MainContentAlignment.center,
                      initialValue: selectedPresets.contains(preset.enumName),
                      onChange: (value) {
                        final activeToggles = Set<String>.from(selectedPresetNotifier.value);
                        final excludedLabels = Set<String>.from(excludedLabelsNotifier.value);

                        final labelsFromToggles = activeToggles
                            .map((e) => presets.firstWhere((element) => element.enumName == e).exclude)
                            .expand((element) => element)
                            .toSet();

                        excludedLabels.removeAll(labelsFromToggles);

                        if (value) {
                          activeToggles.add(preset.enumName);
                        } else {
                          activeToggles.remove(preset.enumName);
                        }

                        for (final activeToggle in activeToggles) {
                          final presetExclude =
                              presets.firstWhere((element) => element.enumName == activeToggle).exclude;
                          excludedLabels.addAll(presetExclude);
                        }

                        excludedLabelsNotifier.value = excludedLabels;
                        selectedPresetNotifier.value = activeToggles;
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
