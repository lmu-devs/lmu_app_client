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
  final _tasteProfileStateNotifier = ValueNotifier<TasteProfileStateModel>(TasteProfileStateModel.empty());
  final _excludedLabelItemNotifier = ValueNotifier<List<TasteProfileLabelItem>>([]);
  final _tasteProfileActiveNotifier = ValueNotifier<bool>(false);

  List<TasteProfileLabelItem>? _labelItems;

  ValueNotifier<TasteProfileModel?> get tasteProfileModel => _tasteProfileNotifier;
  ValueNotifier<TasteProfileStateModel> get tasteProfileState => _tasteProfileStateNotifier;
  ValueNotifier<List<TasteProfileLabelItem>> get excludedLabelItemNotifier => _excludedLabelItemNotifier;
  ValueNotifier<bool> get tasteProfileActiveNotifier => _tasteProfileActiveNotifier;

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
      _tasteProfileStateNotifier.value = tasteProfileState;

      _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
      _tasteProfileActiveNotifier.value = tasteProfileState.isActive;

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

    _tasteProfileStateNotifier.value = saveModel;
    _excludedLabelItemNotifier.value = _mapExcludedLabelItems;
    _tasteProfileActiveNotifier.value = isActive;
  }

  List<TasteProfileLabelItem> get _mapExcludedLabelItems {
    final tasteProfile = _tasteProfileNotifier.value;
    if (tasteProfile != null) {
      return tasteProfile.sortedLabels
          .expand((label) => label.items)
          .where((item) => _tasteProfileStateNotifier.value.excludedLabels.contains(item.enumName))
          .toList();
    }
    return [];
  }
}
