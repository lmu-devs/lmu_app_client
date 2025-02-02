import 'dart:convert';

import 'package:core/api.dart';
import 'package:get_it/get_it.dart';

import 'models/timeline_data.dart';
import 'timeline_api_endpoints.dart';

class TimelineApiClient {
  final _baseApiClient = GetIt.I.get<BaseApiClient>();

  Future<TimelineData> getTimeline() async {
    final response = await _baseApiClient.get(TimelineApiEndpoints.timeline);
    return TimelineData.fromJson(jsonDecode(response.body));
  }
}
