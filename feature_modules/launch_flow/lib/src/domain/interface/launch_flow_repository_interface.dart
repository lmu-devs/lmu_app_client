abstract class LaunchFlowRepositoryInterface {
  Future<bool> shouldShowWelcomePage();

  Future<void> showedWelcomePage();
}
