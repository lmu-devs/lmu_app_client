import 'package:core/localizations.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/session_model.dart';

part 'sessions_details_page_driver.g.dart';

const _testSession = SessionModel(
  caption: "Caption",
  startingTime: "08:00:00",
  endingTime: "10:00:00",
  rhythm: "woch",
);

@GenerateTestDriver()
class SessionsDetailsPageDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  SessionsDetailsPageDriver({
    @driverProvidableProperty required this.sessions,
  });

  @TestDriverDefaultValue([_testSession])
  final List<SessionModel> sessions;

  late LmuLocalizations _localizations;

  String get pageTitle => _localizations.courses.sessions;

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  void didUpdateProvidedProperties({required List<SessionModel> newSessions}) {}
}
