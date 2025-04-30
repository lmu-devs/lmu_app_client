import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get_it/get_it.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import '../bloc/taste_profile/taste_profile_cubit.dart';
import '../bloc/taste_profile/taste_profile_state.dart';
import '../repository/api/models/taste_profile/taste_profile.dart';
import '../services/taste_profile_service.dart';
import '../widgets/taste_profile/taste_profile_footer_section.dart';
import '../widgets/taste_profile/taste_profile_presets_section.dart';
import '../widgets/taste_profile/taste_profile_title_section.dart';
import '../widgets/taste_profile/taste_profile_toggle_section.dart';

class TasteProfilePage extends StatefulWidget {
  const TasteProfilePage({super.key});

  @override
  State<TasteProfilePage> createState() => _TasteProfilePageState();
}

class _TasteProfilePageState extends State<TasteProfilePage> {
  final _tasteProfileCubit = GetIt.I.get<TasteProfileCubit>();
  final _tasteProfileService = GetIt.I.get<TasteProfileService>();

  ScrollController? _scrollController;
  late final ListController _listController;
  late ValueNotifier<bool> _isActiveNotifier;
  late ValueNotifier<Set<String>> _excludedLabelsNotifier;
  late ValueNotifier<String?> _selectedPreferencePresetsNotifier;
  late ValueNotifier<Set<String>> _selectedAllergiesPresetsNotifier;
  late Set<String> _initialExcludedLabels;

  late ValueNotifier<int> _activeIndexNotifier;

  @override
  void initState() {
    super.initState();

    _tasteProfileService.onOpen();

    _isActiveNotifier = _tasteProfileService.isActiveNotifier;
    _excludedLabelsNotifier = _tasteProfileService.excludedLabelsNotifier;
    _selectedAllergiesPresetsNotifier = _tasteProfileService.selectedAllergiesPresetsNotifier;
    _selectedPreferencePresetsNotifier = _tasteProfileService.selectedPreferencePresetNotifier;
    _initialExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    _activeIndexNotifier = ValueNotifier<int>(0);
    _listController = ListController();

    if (_tasteProfileCubit.state is! TasteProfileLoadSuccess) {
      _tasteProfileCubit.loadTasteProfile();
    }

    _listController.addListener(_onListControllerValue);
  }

  @override
  void dispose() {
    _listController.removeListener(_onListControllerValue);
    super.dispose();
  }

  void _onListControllerValue() {
    final visibleStart = _listController.unobstructedVisibleRange?.$1 ?? 0;
    if (_activeIndexNotifier.value != visibleStart) {
      _activeIndexNotifier.value = visibleStart;
    }
  }

  void _animateToItem(int index) {
    _listController.animateToItem(
      index: index,
      scrollController: _scrollController!,
      alignment: 0,
      duration: (estimatedDistance) => const Duration(milliseconds: 500),
      curve: (estimatedDistance) => LmuAnimations.slowSmooth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    _scrollController = context.modalScrollController;

    return BlocBuilder<TasteProfileCubit, TasteProfileState>(
      bloc: _tasteProfileCubit,
      builder: (context, state) {
        return LmuScaffold(
          appBar: LmuAppBarData(
            largeTitle: localizations.myTaste,
            trailingWidgets: const [_SaveButton()],
            leadingAction: LeadingAction.close,
            onLeadingActionTap: () => _onLeadingClose(context),
          ),
          isBottomSheet: true,
          customScrollController: _scrollController,
          onPopInvoked: () async => await _onPopInvoked(context),
          slivers: state is TasteProfileLoadSuccess
              ? _getContentSliver(state.tasteProfile)
              : _getLoadingSlivers(context.locals.canteen),
        );
      },
    );
  }

  List<Widget> _getContentSliver(TasteProfileModel tasteProfile) {
    return [
      const SliverToBoxAdapter(child: TasteProfileTitleSection()),
      const SliverToBoxAdapter(child: TasteProfileToggleSection()),
      SliverToBoxAdapter(child: TasteProfilePresetsSection(tasteProfileModel: tasteProfile)),
      const SliverToBoxAdapter(child: _LabelsHeader()),
      PinnedHeaderSliver(
        child: LmuTabBar(
          activeTabIndexNotifier: _activeIndexNotifier,
          items: tasteProfile.sortedLabels.map((e) => LmuTabBarItemData(title: e.name)).toList(),
          hasDivider: true,
          onTabChanged: (index, tabItem) => _animateToItem(index),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        sliver: SuperSliverList.builder(
          itemCount: tasteProfile.sortedLabels.length,
          listController: _listController,
          itemBuilder: (context, index) {
            final label = tasteProfile.sortedLabels[index];
            final sortedLabelItems = label.items.toList()..sort((a, b) => a.text.compareTo(b.text));
            return Padding(
              key: Key("taste_profile_label_section$index"),
              padding: const EdgeInsets.only(top: LmuSizes.size_16),
              child: LmuContentTile(
                contentList: sortedLabelItems.map(
                  (labelItem) {
                    return ValueListenableBuilder(
                      valueListenable: _excludedLabelsNotifier,
                      builder: (context, excludedLabels, _) {
                        return LmuListItem.action(
                          title: labelItem.text,
                          leadingArea: LmuText.body(
                            (labelItem.emojiAbbreviation ?? "").isEmpty ? "🫙" : labelItem.emojiAbbreviation,
                          ),
                          actionType: LmuListItemAction.checkbox,
                          mainContentAlignment: MainContentAlignment.center,
                          initialValue: !excludedLabels.contains(labelItem.enumName),
                          onChange: (value) => _onToggleChange(value, labelItem, tasteProfile),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ),
      const SliverToBoxAdapter(child: TasteProfileFooterSection()),
    ];
  }

  void _onToggleChange(bool value, TasteProfileLabelItem item, TasteProfileModel tasteProfile) {
    final newExcludedLabels = Set<String>.from(_excludedLabelsNotifier.value);

    if (value) {
      newExcludedLabels.remove(item.enumName);
    } else {
      newExcludedLabels.add(item.enumName);
    }

    final selectedAllergiesPresets = Set<String>.from(_selectedAllergiesPresetsNotifier.value);
    for (final allergiesPreset in tasteProfile.allergiesPresets) {
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
    for (final preferencesPreset in tasteProfile.preferencesPresets) {
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

  List<Widget> _getLoadingSlivers(CanteenLocalizations localizations) {
    const preferencePresetsItems = 4;
    const allergiesPresetsItems = 2;
    const labelsItems = [4, 2, 3, 5];

    return [
      const SliverToBoxAdapter(child: TasteProfileTitleSection()),
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              LmuContentTile(
                content: LmuListItemLoading(
                  titleLength: 2,
                  action: LmuListItemAction.toggle,
                ),
              ),
              SizedBox(height: LmuSizes.size_32),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: Column(
            children: [
              LmuTileHeadline.base(title: localizations.presets),
              LmuContentTile(
                contentList: [
                  for (var i = 0; i < preferencePresetsItems; i++)
                    LmuListItemLoading(
                      titleLength: 2,
                      leadingArea: LmuText.body('🍔'),
                      action: LmuListItemAction.radio,
                    ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_16),
              LmuContentTile(
                contentList: [
                  for (var i = 0; i < allergiesPresetsItems; i++)
                    LmuListItemLoading(
                      titleLength: 2,
                      leadingArea: LmuText.body('🍔'),
                      action: LmuListItemAction.checkbox,
                    ),
                ],
              ),
              const SizedBox(height: LmuSizes.size_32),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
          child: LmuTileHeadline.base(title: localizations.tastePreferences),
        ),
      ),
      SliverStickyHeader(
        header: const LmuTabBarLoading(
          hasDivider: true,
        ),
        sliver: SliverPadding(
          padding: const EdgeInsets.only(left: LmuSizes.size_16, right: LmuSizes.size_16, top: LmuSizes.size_16),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                for (var i = 0; i < labelsItems.length; i++)
                  Column(
                    children: [
                      LmuContentTile(
                        contentList: [
                          for (var j = 0; j < labelsItems[i]; j++)
                            LmuListItemLoading(
                              titleLength: 2,
                              leadingArea: LmuText.body('🍔'),
                              action: LmuListItemAction.checkbox,
                            ),
                        ],
                      ),
                      const SizedBox(height: LmuSizes.size_16),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      const SliverToBoxAdapter(child: TasteProfileFooterSection()),
    ];
  }

  Future<void> _showUnsavedChangesDialog(
    BuildContext context, {
    required void Function() onDiscardPressed,
    void Function()? onContinuePressed,
  }) async {
    final appLocals = context.locals.app;
    final canteenLocals = context.locals.canteen;
    await LmuDialog.show(
      context: context,
      title: canteenLocals.unsavedChanges,
      description: canteenLocals.unsavedChangesDescription,
      buttonActions: [
        LmuDialogAction(
          title: appLocals.discard,
          isSecondary: true,
          onPressed: (context) {
            onDiscardPressed();
            _tasteProfileService.onClose();
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

  Future<bool> _onPopInvoked(BuildContext context) async {
    bool shouldClose = true;
    if (_tasteProfileService.hasNoChanges) return shouldClose;

    await _showUnsavedChangesDialog(
      context,
      onDiscardPressed: () => shouldClose = true,
      onContinuePressed: () => shouldClose = false,
    );

    return shouldClose;
  }

  void _onLeadingClose(BuildContext context) async {
    final sheetNavigator = Navigator.of(context);

    if (_tasteProfileService.hasNoChanges) {
      _tasteProfileService.onClose();
      sheetNavigator.pop();
      return;
    }

    _showUnsavedChangesDialog(context, onDiscardPressed: () => sheetNavigator.pop());
  }
}

class _LabelsHeader extends StatelessWidget {
  const _LabelsHeader();

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: LmuTileHeadline.action(
        title: localizations.tastePreferences,
        actionTitle: localizations.reset,
        onActionTap: GetIt.I.get<TasteProfileService>().reset,
      ),
    );
  }
}

class _SaveButton extends StatefulWidget {
  const _SaveButton();

  @override
  State<_SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<_SaveButton> {
  late ValueNotifier<bool> _isActiveNotifier;
  late ValueNotifier<Set<String>> _excludedLabelsNotifier;
  late bool _initialIsActive;
  late Set<String> _initialExcludedLabels;

  final tasteProfileService = GetIt.I.get<TasteProfileService>();

  @override
  void initState() {
    super.initState();
    _isActiveNotifier = tasteProfileService.isActiveNotifier;
    _initialIsActive = _isActiveNotifier.value;
    _excludedLabelsNotifier = tasteProfileService.excludedLabelsNotifier;
    _initialExcludedLabels = _excludedLabelsNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;
    return ValueListenableBuilder(
      valueListenable: tasteProfileService.isActiveNotifier,
      builder: (context, isActive, _) {
        return ValueListenableBuilder(
          valueListenable: tasteProfileService.excludedLabelsNotifier,
          builder: (context, excludedLabels, _) {
            final isDisabled = setEquals(excludedLabels, _initialExcludedLabels) && _initialIsActive == isActive;

            return LmuButton(
              title: localizations.save,
              emphasis: ButtonEmphasis.link,
              state: isDisabled ? ButtonState.disabled : ButtonState.enabled,
              size: ButtonSize.large,
              increaseTouchTarget: true,
              textScaleFactorEnabled: false,
              onTap: () {
                tasteProfileService.saveTasteProfileState(
                  selectedAllergiesPresets: tasteProfileService.selectedAllergiesPresetsNotifier.value,
                  excludedLabels: _excludedLabelsNotifier.value,
                  isActive: _isActiveNotifier.value,
                  selectedPreferencePreset: tasteProfileService.selectedPreferencePresetNotifier.value,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          },
        );
      },
    );
  }
}
