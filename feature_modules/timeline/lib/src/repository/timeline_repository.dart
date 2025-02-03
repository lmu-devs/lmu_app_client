import 'package:get_it/get_it.dart';

import 'api/api.dart';

abstract class TimelineRepository {
  Future<TimelineData> getTimeline();
}

class ConnectedTimelineRepository implements TimelineRepository {
  final _apiClient = GetIt.I.get<TimelineApiClient>();

  @override
  Future<TimelineData> getTimeline() async {
    return _apiClient.getTimeline();
  }
}
