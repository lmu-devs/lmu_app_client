import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../repository/api/models/menu/menu_day_model.dart';
import '../repository/mensa_repository.dart';

class MenuService {
  MenuService({
    required this.canteenId,
  }) {
    loadMensaMenuData();
  }
  final String canteenId;

  final MensaRepository _mensaRepository = GetIt.I.get<MensaRepository>();

  ValueNotifier<List<MenuDayModel>?> _mensaMenuModels = ValueNotifier(null);

  ValueNotifier<List<MenuDayModel>?> get mensaMenuModels => _mensaMenuModels;

  Future<void> loadMensaMenuData() async {
    try {
      final mensaMenuModels = await _mensaRepository.getMenuDayForMensa(canteenId);

      _mensaMenuModels.value = mensaMenuModels;
    } catch (e) {
      _mensaMenuModels.value = [];
    }
  }
}
