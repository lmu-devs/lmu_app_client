import 'package:collection/collection.dart';
import 'package:core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../bloc/taste_profile/taste_profile_cubit.dart';
import '../bloc/taste_profile/taste_profile_state.dart';
import '../repository/api/models/taste_profile/taste_profile.dart';
import '../repository/mensa_repository.dart';
import '../repository/repository.dart';

class TasteProfileService {
  TasteProfileService();

  final _mensaRepository = GetIt.I.get<MensaRepository>();

  final _excludedLabelItemNotifier = ValueNotifier<List<TasteProfileLabelItem>>([]);
  final _isActiveNotifier = ValueNotifier<bool>(false);
  final _selectedAllergiesPresetsNotifier = ValueNotifier<Set<String>>({});
  final _selectedPreferencePresetNotifier = ValueNotifier<String?>(null);
  final _excludedLabelsNotifier = ValueNotifier<Set<String>>({});

  List<TasteProfileLabelItem>? _labelItems;
  TasteProfileStateModel currentTasteProfileState = TasteProfileStateModel.empty();

  ValueNotifier<List<TasteProfileLabelItem>> get excludedLabelItemNotifier => _excludedLabelItemNotifier;

  ValueNotifier<bool> get isActiveNotifier => _isActiveNotifier;
  ValueNotifier<Set<String>> get selectedAllergiesPresetsNotifier => _selectedAllergiesPresetsNotifier;
  ValueNotifier<String?> get selectedPreferencePresetNotifier => _selectedPreferencePresetNotifier;
  ValueNotifier<Set<String>> get excludedLabelsNotifier => _excludedLabelsNotifier;

  bool _initialIsActive = false;
  Set<String> _initialSelectedAllergiesPresets = {};
  String? _initialSelectedPreferencePreset = '';
  Set<String> _initialExcludedLabels = {};

  void onOpen() {
    _initialIsActive = _isActiveNotifier.value;
    _initialSelectedAllergiesPresets = _selectedAllergiesPresetsNotifier.value;
    _initialSelectedPreferencePreset = _selectedPreferencePresetNotifier.value;
    _initialExcludedLabels = _excludedLabelsNotifier.value;
  }

  void onClose() {
    _isActiveNotifier.value = _initialIsActive;
    _selectedAllergiesPresetsNotifier.value = _initialSelectedAllergiesPresets;
    _selectedPreferencePresetNotifier.value = _initialSelectedPreferencePreset;
    _excludedLabelsNotifier.value = _initialExcludedLabels;
  }

  void reset() async {
    final tasteProfile = (GetIt.I.get<TasteProfileCubit>().state as TasteProfileLoadSuccess).tasteProfile;
    final initialPreferencePreset = tasteProfile.preferencesPresets.first.enumName;
    _selectedAllergiesPresetsNotifier.value = {};
    _selectedPreferencePresetNotifier.value = initialPreferencePreset;
    _excludedLabelsNotifier.value = {};
    _isActiveNotifier.value = false;

    currentTasteProfileState = TasteProfileStateModel(
      selectedAllergiesPresets: const {},
      selectedPreferencePreset: initialPreferencePreset,
      excludedLabels: const {},
      isActive: false,
    );

    await _mensaRepository.saveTasteProfileState(currentTasteProfileState);
  }

  TasteProfileLabelItem? getLabelItemFromId(String id) {
    return _labelItems?.firstWhereOrNull((item) => item.enumName == id);
  }

  void init() async {
    currentTasteProfileState = await _mensaRepository.getTasteProfileState();
    _isActiveNotifier.value = currentTasteProfileState.isActive;
    _selectedAllergiesPresetsNotifier.value = currentTasteProfileState.selectedAllergiesPresets;
    _selectedPreferencePresetNotifier.value = currentTasteProfileState.selectedPreferencePreset;
    _excludedLabelsNotifier.value = currentTasteProfileState.excludedLabels;

    final tasteProfileCubit = GetIt.I.get<TasteProfileCubit>();

    tasteProfileCubit.stream
        .withInitialValue(tasteProfileCubit.state)
        .where((state) => state is TasteProfileLoadSuccess)
        .listen(
      (state) {
        final tasteProfile = (state as TasteProfileLoadSuccess).tasteProfile;
        _labelItems = tasteProfile.sortedLabels.expand((label) => label.items).toList();
        _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
        _selectedPreferencePresetNotifier.value ??= tasteProfile.preferencesPresets.first.enumName;
      },
    );
  }

  Future<void> saveTasteProfileState({
    required Set<String> selectedAllergiesPresets,
    required String? selectedPreferencePreset,
    required Set<String> excludedLabels,
    required bool isActive,
  }) async {
    currentTasteProfileState = TasteProfileStateModel(
      selectedAllergiesPresets: selectedAllergiesPresets,
      selectedPreferencePreset: selectedPreferencePreset,
      excludedLabels: excludedLabels,
      isActive: isActive,
    );

    await _mensaRepository.saveTasteProfileState(currentTasteProfileState);

    _isActiveNotifier.value = isActive;
    _selectedAllergiesPresetsNotifier.value = selectedAllergiesPresets;
    _selectedPreferencePresetNotifier.value = selectedPreferencePreset;
    _excludedLabelsNotifier.value = excludedLabels;
    _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
  }

  List<TasteProfileLabelItem> get _mapExcludedLabelItems {
    final tasteProfileState = GetIt.I.get<TasteProfileCubit>().state;
    if (tasteProfileState is TasteProfileLoadSuccess) {
      return tasteProfileState.tasteProfile.sortedLabels
          .expand((label) => label.items)
          .where((item) => _excludedLabelsNotifier.value.contains(item.enumName))
          .toList();
    }
    return [];
  }
}
