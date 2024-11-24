import 'package:core/module.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/feedback.dart';

import 'services/default_feedback_service.dart';

class FeedbackModule extends AppModule with PublicApiProvidingAppModule {
  @override
  String get moduleName => 'FeedbackModule';


  @override
  void providePublicApi() {
    GetIt.I.registerSingleton<FeedbackService>(DefaultFeedbackService());
  }
}
