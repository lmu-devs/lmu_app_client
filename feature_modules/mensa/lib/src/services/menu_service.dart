import '../bloc/bloc.dart';

class MenuService {
  final Map<String, MenuCubit> _menuCubits = {};

  MenuCubit getMenuCubit(String canteenId) {
    final cubit = _menuCubits[canteenId];
    if (cubit == null) throw Exception("No MenuCubit found for canteenId $canteenId");
    return cubit;
  }

  bool hasMenuCubit(String canteenId) => _menuCubits.containsKey(canteenId);

  void initMenuCubit(String canteenId) {
    if (_menuCubits.containsKey(canteenId)) throw Exception("MenuCubit already initialized for canteenId $canteenId");
    _menuCubits[canteenId] = MenuCubit(canteenId: canteenId);
  }

  Future<void> dispose() async {
    _menuCubits.forEach((key, value) async {
      await value.close();
    });
    _menuCubits.clear();
  }
}
