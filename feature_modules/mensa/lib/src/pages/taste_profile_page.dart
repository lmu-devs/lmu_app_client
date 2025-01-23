import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/taste_profile/taste_profile_cubit.dart';
import '../bloc/taste_profile/taste_profile_state.dart';
import '../services/taste_profile_service.dart';
import '../views/views.dart';

class TasteProfilePage extends StatefulWidget {
  const TasteProfilePage({super.key});

  @override
  State<TasteProfilePage> createState() => _TasteProfilePageState();
}

class _TasteProfilePageState extends State<TasteProfilePage> {
  final _tasteProfileCubit = GetIt.I.get<TasteProfileCubit>();
  final _tasteProfileService = GetIt.I.get<TasteProfileService>();

  @override
  void initState() {
    super.initState();

    _tasteProfileService.onOpen();

    if (_tasteProfileCubit.state is! TasteProfileLoadSuccess) {
      _tasteProfileCubit.loadTasteProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.canteen;

    return LmuMasterAppBar.bottomSheet(
      largeTitle: localizations.myTaste,
      trailingWidgets: const [_SaveButton()],
      onPopInvoked: (value) => _tasteProfileService.onClose(),
      onLeadingActionTap: () => _tasteProfileService.onClose(),
      body: BlocBuilder<TasteProfileCubit, TasteProfileState>(
        bloc: _tasteProfileCubit,
        builder: (context, state) {
          if (state is TasteProfileLoadSuccess) {
            return const TasteProfileContentView();
          }

          return const TasteProfileLoadingView();
        },
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
