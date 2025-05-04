import 'package:core/core_services.dart';

import '../../../domain/interfaces/feedback_repository_interface.dart';
import '../../../domain/models/user_feedback.dart';
import '../data/api/feedback_api_client.dart';
import '../data/dto/user_feedback_dto.dart';

class FeedbackRepository implements FeedbackRepositoryInterface {
  const FeedbackRepository(this._apiClient, this._systemInfo);

  final FeedbackApiClient _apiClient;
  final SystemInfo _systemInfo;

  @override
  Future<void> sendFeedback(UserFeedback feedback) {
    final dto = UserFeedbackDto.from(
      feedback,
      _systemInfo.appVersion,
      _systemInfo.systemVersion,
    );
    return _apiClient.sendFeedback(dto);
  }
}
