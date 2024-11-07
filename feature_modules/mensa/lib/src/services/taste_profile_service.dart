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
  final _tasteProfileStateNotifier = ValueNotifier<TasteProfileSaveModel>(TasteProfileSaveModel.empty());

  ValueNotifier<TasteProfileModel?> get tasteProfileModel => _tasteProfileNotifier;
  ValueNotifier<TasteProfileSaveModel> get tasteProfileState => _tasteProfileStateNotifier;
  List<TasteProfileLabelItem> get excludedLabelItems {
    final tasteProfile = _tasteProfileNotifier.value;
    if (tasteProfile != null) {
      return tasteProfile.sortedLabels
          .expand((label) => label.items)
          .where((item) => _tasteProfileStateNotifier.value.excludedLabels.contains(item.enumName))
          .toList();
    }
    return [];
  }

  Future<void> loadTasteProfile() async {
    try {
      final loadedTasteProfile = await _mensaRepository.getTasteProfileContent();
      _tasteProfileNotifier.value = loadedTasteProfile;
    } catch (e) {
      print('Error loading taste profile: $e');
    }
  }

  Future<TasteProfileSaveModel> loadTasteProfileState() async {
    final tasteProfileState = await _mensaRepository.getTasteProfileState();
    _tasteProfileStateNotifier.value = tasteProfileState;
    return tasteProfileState;
  }

  Future<void> saveTasteProfileState({
    required Set<String> selectedPresets,
    required Set<String> excludedLabels,
    required bool isActive,
  }) async {
    final saveModel = TasteProfileSaveModel(
      selectedPresets: selectedPresets,
      excludedLabels: excludedLabels,
      isActive: isActive,
    );
    await _mensaRepository.saveTasteProfileState(saveModel);

    _tasteProfileStateNotifier.value = saveModel;
  }
}
