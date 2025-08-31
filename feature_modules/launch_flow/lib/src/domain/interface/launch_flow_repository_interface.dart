abstract class LaunchFlowRepositoryInterface {
  Future<bool> shouldShowWelcomePage();

  Future<void> showedWelcomePage();

  Future<bool> shouldShowFacultySelectionPage();

  Future<void> showedFacultySelectionPage();

  Future<bool> shouldShowPermissionsOnboardingPage();

  Future<void> showedPermissionsOnboardingPage();
}
