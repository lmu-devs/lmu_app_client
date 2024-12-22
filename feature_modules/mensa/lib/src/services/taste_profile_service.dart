import 'package:collection/collection.dart';
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
  final _selectedPresetsNotifier = ValueNotifier<Set<String>>({});
  final _excludedLabelsNotifier = ValueNotifier<Set<String>>({});

  List<TasteProfileLabelItem>? _labelItems;

  ValueNotifier<List<TasteProfileLabelItem>> get excludedLabelItemNotifier => _excludedLabelItemNotifier;

  ValueNotifier<bool> get isActiveNotifier => _isActiveNotifier;
  ValueNotifier<Set<String>> get selectedPresetsNotifier => _selectedPresetsNotifier;
  ValueNotifier<Set<String>> get excludedLabelsNotifier => _excludedLabelsNotifier;

  void reset() {
    _selectedPresetsNotifier.value = {};
    _excludedLabelsNotifier.value = {};
    _isActiveNotifier.value = false;
  }

  TasteProfileLabelItem? getLabelItemFromId(String id) {
    return _labelItems?.firstWhereOrNull((item) => item.enumName == id);
  }

  void init() async {
    GetIt.I.get<TasteProfileCubit>().stream.where((state) => state is TasteProfileLoadSuccess).listen(
      (state) {
        final tasteProfile = (state as TasteProfileLoadSuccess).tasteProfile;
        _labelItems = tasteProfile.sortedLabels.expand((label) => label.items).toList();
        _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
      },
    );

    final tasteProfileState = await _mensaRepository.getTasteProfileState();
    _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
    _isActiveNotifier.value = tasteProfileState.isActive;
    _selectedPresetsNotifier.value = tasteProfileState.selectedPresets;
    _excludedLabelsNotifier.value = tasteProfileState.excludedLabels;
  }

  Future<void> saveTasteProfileState({
    required Set<String> selectedPresets,
    required Set<String> excludedLabels,
    required bool isActive,
  }) async {
    final saveModel = TasteProfileStateModel(
      selectedPresets: selectedPresets,
      excludedLabels: excludedLabels,
      isActive: isActive,
    );

    await _mensaRepository.saveTasteProfileState(saveModel);

    _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
    _isActiveNotifier.value = isActive;
    _selectedPresetsNotifier.value = selectedPresets;
    _excludedLabelsNotifier.value = excludedLabels;
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
