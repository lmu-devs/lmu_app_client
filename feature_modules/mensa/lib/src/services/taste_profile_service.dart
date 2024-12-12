import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../repository/api/models/taste_profile/taste_profile.dart';
import '../repository/mensa_repository.dart';
import '../repository/repository.dart';

class TasteProfileService {
  TasteProfileService({
    required MensaRepository mensaRepository,
  }) : _mensaRepository = mensaRepository;

  final MensaRepository _mensaRepository;

  final _tasteProfileNotifier = ValueNotifier<TasteProfileModel?>(null);
  final _excludedLabelItemNotifier = ValueNotifier<List<TasteProfileLabelItem>>([]);
  final _isActiveNotifier = ValueNotifier<bool>(false);
  final _selectedPresetsNotifier = ValueNotifier<Set<String>>({});
  final _excludedLabelsNotifier = ValueNotifier<Set<String>>({});

  List<TasteProfileLabelItem>? _labelItems;

  ValueNotifier<TasteProfileModel?> get tasteProfileNotifier => _tasteProfileNotifier;
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
    final tasteProfile = _tasteProfileNotifier.value;
    if (tasteProfile != null) {
      return _labelItems?.firstWhereOrNull((item) => item.enumName == id);
    }
    return null;
  }

  Future<void> loadTasteProfile() async {
    try {
      final loadedTasteProfile = await _mensaRepository.getTasteProfileContent();
      _tasteProfileNotifier.value = loadedTasteProfile;

      final tasteProfileState = await _mensaRepository.getTasteProfileState();

      _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
      _isActiveNotifier.value = tasteProfileState.isActive;
      _selectedPresetsNotifier.value = tasteProfileState.selectedPresets;
      _excludedLabelsNotifier.value = tasteProfileState.excludedLabels;

      _labelItems = loadedTasteProfile.sortedLabels.expand((label) => label.items).toList();
    } catch (e) {
      print('Error loading taste profile: $e');
    }
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
    final tasteProfile = _tasteProfileNotifier.value;
    if (tasteProfile != null) {
      return tasteProfile.sortedLabels
          .expand((label) => label.items)
          .where((item) => _excludedLabelsNotifier.value.contains(item.enumName))
          .toList();
    }
    return [];
  }
}
