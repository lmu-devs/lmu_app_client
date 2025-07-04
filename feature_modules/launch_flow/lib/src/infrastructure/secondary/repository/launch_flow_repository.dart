import '../../../domain/interface/launch_flow_repository_interface.dart';
import '../data/storage/launch_flow_storage.dart';

class LaunchFlowRepository implements LaunchFlowRepositoryInterface {
  const LaunchFlowRepository(this._storage);

  final LaunchFlowStorage _storage;

  @override
  Future<bool> shouldShowWelcomePage() async {
    return await _storage.getShowWelcomePage() ?? true;
  }

  @override
  Future<void> showedWelcomePage() {
    return _storage.saveShowedWelcomePage();
  }

  @override
  Future<bool> shouldShowFacultySelectionPage() async {
    return await _storage.getShowFacultySelectionPage() ?? true;
  }

  @override
  Future<void> showedFacultySelectionPage() {
    return _storage.saveShowedFacultySelectionPage();
  }
}
