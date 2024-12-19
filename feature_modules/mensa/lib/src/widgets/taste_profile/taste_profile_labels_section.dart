import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../bloc/taste_profile/taste_profile_cubit.dart';
import '../../bloc/taste_profile/taste_profile_state.dart';
import '../../services/taste_profile_service.dart';

class TasteProfileLabelsSection extends StatelessWidget {
  const TasteProfileLabelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tasteProfileService = GetIt.I.get<TasteProfileService>();
    final selectedPresetNotifier = tasteProfileService.selectedPresetsNotifier;
    final excludedLabelsNotifier = tasteProfileService.excludedLabelsNotifier;
    final selectedLanguage = Localizations.localeOf(context).languageCode.toUpperCase();

    final itemPositionsListener = ItemPositionsListener.create();
    final itemScrollController = ItemScrollController();
    final scrollOffsetController = ScrollOffsetController();

    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      final firstIndex = positions.isNotEmpty ? positions.first.index : 0;
      final label = tasteProfileService.getLabelItemFromId(firstIndex.toString());
      if (label != null) {
        print('First visible label: ${label.text[selectedLanguage]}');
      }
    });

    final stickyHeaderController = StickyHeaderController();
    stickyHeaderController.addListener(() {
      final index = stickyHeaderController.stickyHeaderScrollOffset;
      print("LELLLL: $index");
    });

    final tasteProfile = (GetIt.I.get<TasteProfileCubit>().state as TasteProfileLoadSuccess).tasteProfile;
    final sortedLabels = tasteProfile.sortedLabels;
    final presets = tasteProfile.presets;

    return SliverStickyHeader(
      controller: stickyHeaderController,
      header: LmuTabBar(
        items: sortedLabels.map((e) => LmuTabBarItemData(title: e.name)).toList(),
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
            valueListenable: excludedLabelsNotifier,
            builder: (context, excludedLabels, _) {
              return ScrollablePositionedList.separated(
                scrollOffsetController: scrollOffsetController,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: LmuSizes.size_16),
                itemCount: sortedLabels.length,
                itemPositionsListener: itemPositionsListener,
                itemScrollController: itemScrollController,
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    SizedBox(height: index != sortedLabels.length - 1 ? LmuSizes.size_16 : 0),
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
                              onChange: (value) {
                                final newExcludedLabels = Set<String>.from(excludedLabelsNotifier.value);
                                final selectedPresets = Set<String>.from(selectedPresetNotifier.value);

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

                                selectedPresetNotifier.value = selectedPresets;
                                excludedLabelsNotifier.value = newExcludedLabels;
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
