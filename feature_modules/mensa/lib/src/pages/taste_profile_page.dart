import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../services/taste_profile_service.dart';
import '../widgets/taste_profile/taste_profile_labels_section.dart';
import '../widgets/taste_profile/taste_profile_presets_section.dart';

class TasteProfilePage extends StatelessWidget {
  const TasteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;

    return LmuMasterAppBar.bottomSheet(
      largeTitle: localizations.myTaste,
      customScrollController: ModalScrollController.of(context),
      trailingWidgets: const [_SaveButton()],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _TitleSection()),
          SliverToBoxAdapter(child: _ToggleSection()),
          SliverToBoxAdapter(child: TasteProfilePresetsSection()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: LmuTileHeadline.action(
                title: localizations.tastePreferences,
                actionTitle: localizations.reset,
                onActionTap: () {
                  // selectedPresetNotifier.value = {};
                  // excludedLabelsNotifier.value = {};
                  // isActiveNotifier.value = true;
                },
              ),
            ),
          ),
          TasteProfileLabelsSection(),
          SliverToBoxAdapter(child: _FooterSection()),
        ],
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
              onTap: () {
                tasteProfileService.saveTasteProfileState(
                  selectedPresets: tasteProfileService.selectedPresetsNotifier.value,
                  excludedLabels: _excludedLabelsNotifier.value,
                  isActive: _isActiveNotifier.value,
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

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: LmuSizes.size_8),
          LmuText.body(
            context.locals.canteen.myTasteDescription,
            color: context.colors.neutralColors.textColors.mediumColors.base,
          ),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }
}

class _ToggleSection extends StatelessWidget {
  const _ToggleSection();

  @override
  Widget build(BuildContext context) {
    final isActiveNotifier = GetIt.I.get<TasteProfileService>().isActiveNotifier;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          LmuContentTile(
            content: [
              ValueListenableBuilder(
                valueListenable: isActiveNotifier,
                builder: (context, isActive, _) {
                  return LmuListItem.action(
                    title: context.locals.canteen.myTaste,
                    actionType: LmuListItemAction.toggle,
                    mainContentAlignment: MainContentAlignment.center,
                    initialValue: isActive,
                    onChange: (value) => isActiveNotifier.value = value,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: LmuSizes.size_32),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
      child: Column(
        children: [
          const SizedBox(height: LmuSizes.size_48),
          LmuText.bodyXSmall(
            context.locals.canteen.myTasteFooter,
            color: context.colors.neutralColors.textColors.weakColors.base,
          ),
          const SizedBox(height: LmuSizes.size_64),
        ],
      ),
    );
  }
}
