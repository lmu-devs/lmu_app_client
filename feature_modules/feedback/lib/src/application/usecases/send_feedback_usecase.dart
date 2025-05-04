import '../../domain/interfaces/feedback_repository_interface.dart';
import '../../domain/models/user_feedback.dart';

class SendFeedbackUsecase {
  const SendFeedbackUsecase(this._repository);

  final FeedbackRepositoryInterface _repository;

  Future<void> call(UserFeedback feedback) async => _repository.sendFeedback(feedback);
}
