import '../../domain/interface/launch_flow_repository_interface.dart';

class ShouldShowWelcomePageUsecase {
  const ShouldShowWelcomePageUsecase(this.repository);

  final LaunchFlowRepositoryInterface repository;

  Future<bool> call() => repository.shouldShowWelcomePage();
}
