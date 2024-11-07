import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';

import '../services/taste_profile_service.dart';

class TasteProfilePage extends StatelessWidget {
  TasteProfilePage({
    super.key,
    required Set<String> selectedPresets,
    required Set<String> excludedLabels,
    required bool isActive,
  })  : _selectedPresetNotifier = ValueNotifier<Set<String>>(selectedPresets),
        _excludedLabelsNotifier = ValueNotifier<Set<String>>(excludedLabels),
        _isActiveNotifier = ValueNotifier<bool>(isActive),
        _initialExcludedLabels = excludedLabels,
        _initialIsActive = isActive;

  final ValueNotifier<Set<String>> _selectedPresetNotifier;
  final ValueNotifier<Set<String>> _excludedLabelsNotifier;
  final ValueNotifier<bool> _isActiveNotifier;
  final Set<String> _initialExcludedLabels;
  final bool _initialIsActive;

  @override
  Widget build(BuildContext context) {
    final tasteProfileService = GetIt.I.get<TasteProfileService>();
    final tasteProfileNotifier = tasteProfileService.tasteProfileModel;

    final selectedLangauge = Localizations.localeOf(context).languageCode.toUpperCase();

    final localizations = context.localizations;

    return ValueListenableBuilder(
      valueListenable: tasteProfileNotifier,
      builder: (context, tasteProfileModel, child) {
        if (tasteProfileModel == null) {
          return const SizedBox.shrink();
        }

        final presets = tasteProfileModel.presets;
        final sortedLabels = tasteProfileModel.sortedLabels;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LmuHeader(
              leadingIcon: LucideIcons.x,
              onLeadingTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              traillingWidget: ValueListenableBuilder(
                valueListenable: _isActiveNotifier,
                builder: (context, isActive, _) {
                  return ValueListenableBuilder(
                    valueListenable: _excludedLabelsNotifier,
                    builder: (context, excludedLabels, child) {
                      final isDisabled =
                          setEquals(excludedLabels, _initialExcludedLabels) && _initialIsActive == isActive;
                      return LmuButton(
                        title: localizations.save,
                        emphasis: ButtonEmphasis.link,
                        state: isDisabled ? ButtonState.disabled : ButtonState.enabled,
                        size: ButtonSize.large,
                        onTap: () {
                          tasteProfileService.saveTasteProfileState(
                            selectedPresets: _selectedPresetNotifier.value,
                            excludedLabels: _excludedLabelsNotifier.value,
                            isActive: _isActiveNotifier.value,
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: LmuSizes.mediumSmall),
                    LmuText.h1(localizations.myTaste),
                    const SizedBox(height: LmuSizes.medium),
                    LmuText.body(localizations.myTasteDescription),
                    const SizedBox(height: LmuSizes.xxlarge),
                    LmuContentTile(
                      content: [
                        ValueListenableBuilder(
                          valueListenable: _isActiveNotifier,
                          builder: (context, isActive, _) {
                            return LmuListItem.action(
                              title: localizations.myTaste,
                              actionType: LmuListItemAction.toggle,
                              mainContentAlignment: MainContentAlignment.center,
                              initialValue: isActive,
                              onChange: (value) {
                                _isActiveNotifier.value = value;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: LmuSizes.xxlarge),
                    LmuTileHeadline.base(title: localizations.presets),
                    ValueListenableBuilder(
                      valueListenable: _selectedPresetNotifier,
                      builder: (contex, selectedPresets, child) {
                        return LmuContentTile(
                          content: [
                            for (final preset in presets)
                              LmuListItem.action(
                                title: preset.text[selectedLangauge],
                                leadingArea: LmuText.body(preset.emojiAbbreviation),
                                actionType: LmuListItemAction.toggle,
                                mainContentAlignment: MainContentAlignment.center,
                                initialValue: selectedPresets.contains(preset.enumName),
                                onChange: (value) {
                                  final activeToggles = Set<String>.from(selectedPresets);
                                  final excludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

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

                                  _excludedLabelsNotifier.value = excludedLabels;
                                  _selectedPresetNotifier.value = activeToggles;
                                },
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: LmuSizes.xxlarge),
                    LmuTileHeadline.action(
                      title: localizations.tastePreferences,
                      actionTitle: localizations.reset,
                      onActionTap: () {
                        _selectedPresetNotifier.value = {};
                        _excludedLabelsNotifier.value = {};
                        _isActiveNotifier.value = true;
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _excludedLabelsNotifier,
                      builder: (context, excludedLabels, child) {
                        return Column(
                          children: [
                            ...sortedLabels.map(
                              (label) => Column(
                                children: [
                                  LmuContentTile(
                                    content: [
                                      for (final item in label.items)
                                        LmuListItem.action(
                                          title: item.text[selectedLangauge],
                                          leadingArea: LmuText.body(
                                            (item.emojiAbbreviation ?? "").isEmpty ? "😀" : item.emojiAbbreviation,
                                          ),
                                          actionType: LmuListItemAction.checkbox,
                                          mainContentAlignment: MainContentAlignment.center,
                                          initialValue: !excludedLabels.contains(item.enumName),
                                          onChange: (value) {
                                            final newExcludedLabels = Set<String>.from(excludedLabels);
                                            final selectedPresets = Set<String>.from(_selectedPresetNotifier.value);

                                            if (value) {
                                              newExcludedLabels.remove(item.enumName);
                                            } else {
                                              newExcludedLabels.add(item.enumName);
                                            }

                                            for (final preset in presets) {
                                              final presetExclude = Set<String>.from(preset.exclude);
                                              final isPresetSelected = selectedPresets.contains(preset.enumName);
                                              final areAllPresetLabelsExcluded =
                                                  newExcludedLabels.containsAll(presetExclude);
                                              if (isPresetSelected) {
                                                if (!areAllPresetLabelsExcluded) {
                                                  selectedPresets.remove(preset.enumName);
                                                }
                                              } else {
                                                if (areAllPresetLabelsExcluded) {
                                                  selectedPresets.add(preset.enumName);
                                                }
                                              }
                                            }
                                            _selectedPresetNotifier.value = selectedPresets;
                                            _excludedLabelsNotifier.value = newExcludedLabels;
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: LmuSizes.mediumLarge)
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: LmuSizes.xxxlarge),
                    LmuText.bodyXSmall(
                      localizations.myTasteFooter,
                      color: context.colors.neutralColors.textColors.weakColors.base,
                    ),
                    const SizedBox(height: LmuSizes.huge),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
