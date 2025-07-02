abstract class LaunchFlowRepositoryInterface {
  Future<bool> shouldShowWelcomePage();

  Future<void> showedWelcomePage();

  Future<bool> shouldShowFacultySelectionPage();

  Future<void> showedFacultySelectionPage();
}
