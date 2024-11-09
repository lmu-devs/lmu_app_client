import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../repository/api/models/taste_profile/taste_profile.dart';
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
    final selectedLanguage = Localizations.localeOf(context).languageCode.toUpperCase();
    final localizations = context.localizations;

    return LmuScaffoldWithAppBar(
      largeTitle: localizations.myTaste,
      leadingWidget: GestureDetector(
        onTap: () => Navigator.of(context, rootNavigator: true).pop(),
        child: LmuIcon(
          icon: LucideIcons.x,
          size: 28,
          color: context.colors.neutralColors.textColors.strongColors.base,
        ),
      ),
      trailingWidget: ValueListenableBuilder(
        valueListenable: _isActiveNotifier,
        builder: (context, isActive, _) {
          return ValueListenableBuilder(
            valueListenable: _excludedLabelsNotifier,
            builder: (context, excludedLabels, _) {
              final isDisabled = setEquals(excludedLabels, _initialExcludedLabels) && _initialIsActive == isActive;

              return LmuButton(
                title: localizations.save,
                emphasis: ButtonEmphasis.link,
                state: isDisabled ? ButtonState.disabled : ButtonState.enabled,
                size: ButtonSize.large,
                onTap: () {
                  _saveTasteProfile(context);
                },
              );
            },
          );
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: tasteProfileNotifier,
        builder: (context, tasteProfileModel, _) {
          if (tasteProfileModel == null) return const SizedBox.shrink();

          final presets = tasteProfileModel.presets;
          final sortedLabels = tasteProfileModel.sortedLabels;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(localizations),
                      _buildToggleSection(localizations),
                      _buildPresetsSection(localizations, selectedLanguage, presets),
                      _buildPreferencesSection(localizations, context.colors, selectedLanguage, presets, sortedLabels),
                      _buildFooter(context, localizations),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitleSection(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.mediumSmall),
          LmuText.body(localizations.myTasteDescription),
          const SizedBox(height: LmuSizes.xxlarge),
        ],
      ),
    );
  }

  Widget _buildToggleSection(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
      child: Column(
        children: [
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
                    onChange: (value) => _isActiveNotifier.value = value,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.xxlarge),
        ],
      ),
    );
  }

  Widget _buildPresetsSection(
    AppLocalizations localizations,
    String selectedLanguage,
    List<TasteProfilePreset> presets,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LmuTileHeadline.base(title: localizations.presets),
          ValueListenableBuilder(
            valueListenable: _selectedPresetNotifier,
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
                      onChange: (value) => _handlePresetChange(preset, value, presets),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: LmuSizes.xxlarge),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection(
    AppLocalizations localizations,
    LmuColors colors,
    String selectedLanguage,
    List<TasteProfilePreset> presets,
    List<TasteProfileLabel> sortedLabels,
  ) {
    final itemPositionsListener = ItemPositionsListener.create();
    final itemScrollController = ItemScrollController();
    final activeIndexNotifier = ValueNotifier<int>(0);
    itemPositionsListener.itemPositions.addListener(() {
      final firstVisibleIndex = itemPositionsListener.itemPositions.value.first.index;
      final lastVisibleIndex = itemPositionsListener.itemPositions.value.last.index;
      print("First visible index: $firstVisibleIndex, Last visible index: $lastVisibleIndex");
      activeIndexNotifier.value = firstVisibleIndex;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
          child: LmuTileHeadline.action(
            title: localizations.tastePreferences,
            actionTitle: localizations.reset,
            onActionTap: _resetPreferences,
          ),
        ),
        LmuTabBar(
          items: const [
            LmuTabBarItemData(title: "Fleisch"),
            LmuTabBarItemData(title: "Fisch"),
            LmuTabBarItemData(title: "Milchprodukte"),
            LmuTabBarItemData(title: "Nüsse"),
            LmuTabBarItemData(title: "Zusatzstoffe"),
            LmuTabBarItemData(title: "Allergene"),
          ],
          activeTabIndexNotifier: activeIndexNotifier,
          onTabChanged: (index, tabItem) {
            itemScrollController.jumpTo(index: index);
          },
        ),
        Divider(
          height: 0.5,
          color: colors.neutralColors.borderColors.seperatorLight,
        ),
        SizedBox(
          height: 1000,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
            child: ValueListenableBuilder(
              valueListenable: _excludedLabelsNotifier,
              builder: (context, excludedLabels, _) {
                return ScrollablePositionedList.separated(
                  padding: const EdgeInsets.only(top: LmuSizes.mediumLarge),
                  itemCount: sortedLabels.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  separatorBuilder: (context, index) => const SizedBox(height: LmuSizes.mediumLarge),
                  itemBuilder: (context, index) {
                    final label = sortedLabels[index];
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
                                onChange: (value) => _handleLabelChange(
                                  item,
                                  value,
                                  presets,
                                ),
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
        //   child: ValueListenableBuilder(
        //     valueListenable: _excludedLabelsNotifier,
        //     builder: (context, excludedLabels, _) {
        //       return Column(
        //         children: [
        //           for (final label in sortedLabels)
        //             Column(
        //               children: [
        //                 LmuContentTile(
        //                   content: [
        //                     for (final item in label.items)
        //                       LmuListItem.action(
        //                         title: item.text[selectedLanguage],
        //                         leadingArea: LmuText.body(
        //                           (item.emojiAbbreviation ?? "").isEmpty ? "😀" : item.emojiAbbreviation,
        //                         ),
        //                         actionType: LmuListItemAction.checkbox,
        //                         mainContentAlignment: MainContentAlignment.center,
        //                         initialValue: !excludedLabels.contains(item.enumName),
        //                         onChange: (value) => _handleLabelChange(
        //                           item,
        //                           value,
        //                           presets,
        //                         ),
        //                       ),
        //                   ],
        //                 ),
        //                 const SizedBox(height: LmuSizes.mediumLarge),
        //               ],
        //             ),
        //         ],
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.mediumLarge),
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.xxxlarge),
          LmuText.bodyXSmall(
            localizations.myTasteFooter,
            color: context.colors.neutralColors.textColors.weakColors.base,
          ),
          const SizedBox(height: LmuSizes.huge),
        ],
      ),
    );
  }

  void _saveTasteProfile(BuildContext context) {
    final tasteProfileService = GetIt.I.get<TasteProfileService>();
    tasteProfileService.saveTasteProfileState(
      selectedPresets: _selectedPresetNotifier.value,
      excludedLabels: _excludedLabelsNotifier.value,
      isActive: _isActiveNotifier.value,
    );
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _resetPreferences() {
    _selectedPresetNotifier.value = {};
    _excludedLabelsNotifier.value = {};
    _isActiveNotifier.value = true;
  }

  void _handlePresetChange(TasteProfilePreset preset, bool value, List<TasteProfilePreset> presets) {
    final activeToggles = Set<String>.from(_selectedPresetNotifier.value);
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
      final presetExclude = presets.firstWhere((element) => element.enumName == activeToggle).exclude;
      excludedLabels.addAll(presetExclude);
    }

    _excludedLabelsNotifier.value = excludedLabels;
    _selectedPresetNotifier.value = activeToggles;
  }

  void _handleLabelChange(TasteProfileLabelItem item, bool value, List<TasteProfilePreset> presets) {
    final newExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);
    final selectedPresets = Set<String>.from(_selectedPresetNotifier.value);

    if (value) {
      newExcludedLabels.remove(item.enumName);
    } else {
      newExcludedLabels.add(item.enumName);
    }

    for (final preset in presets) {
      final presetExclude = Set<String>.from(preset.exclude);
      final isPresetSelected = selectedPresets.contains(preset.enumName);
      final areAllPresetLabelsExcluded = newExcludedLabels.containsAll(presetExclude);

      if (isPresetSelected && !areAllPresetLabelsExcluded) {
        selectedPresets.remove(preset.enumName);
      } else if (!isPresetSelected && areAllPresetLabelsExcluded) {
        selectedPresets.add(preset.enumName);
      }
    }

    _selectedPresetNotifier.value = selectedPresets;
    _excludedLabelsNotifier.value = newExcludedLabels;
  }
}
