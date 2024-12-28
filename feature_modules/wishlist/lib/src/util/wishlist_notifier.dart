import 'package:flutter/foundation.dart';

import '../repository/api/api.dart';

class WishlistNotifier extends ChangeNotifier implements ValueListenable<List<WishlistModel>> {
  final List<WishlistModel> _wishlistModels;

  WishlistNotifier(this._wishlistModels);

  @override
  List<WishlistModel> get value => List.unmodifiable(_wishlistModels);

  void updateWishlistModels(List<WishlistModel> newModels) {
    _wishlistModels.clear();
    _wishlistModels.addAll(newModels);
    notifyListeners();
  }

  void updateWishlistModel(WishlistModel updatedModel) {
    final index = _wishlistModels.indexWhere((model) => model.id == updatedModel.id);
    if (index != -1) {
      _wishlistModels[index] = updatedModel;
      notifyListeners();
    }
  }

  WishlistModel? getWishlistModelById(int id) {
    final model = _wishlistModels.where((model) => model.id == id);
    return model.isNotEmpty ? model.first : null;
  }
}
