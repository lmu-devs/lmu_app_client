import '../../domain/interface/launch_flow_repository_interface.dart';

class ShowedWelcomePageUsecase {
  const ShowedWelcomePageUsecase(this.repository);

  final LaunchFlowRepositoryInterface repository;

  Future<void> call() => repository.showedWelcomePage();
}
