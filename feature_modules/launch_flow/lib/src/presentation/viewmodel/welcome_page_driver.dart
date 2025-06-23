import 'package:core/localizations.dart';
import 'package:core_routes/home.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';
import 'package:widget_driver/widget_driver.dart';

part 'welcome_page_driver.g.dart';

typedef WelcomePageEntry = ({String emoji, String title, String description});

@GenerateTestDriver()
class WelcomePageDriver extends WidgetDriver {
  late LaunchFlowLocatizations _flowLocalizations;
  late BuildContext _navigatorContext;

  List<WelcomePageEntry> get _entries => <WelcomePageEntry>[
        (
          emoji: '🤝',
          title: _flowLocalizations.campusCompanionTitle,
          description: _flowLocalizations.campusCompanionDescription,
        ),
        (
          emoji: '🧑‍💻',
          title: _flowLocalizations.developedByStudentsTitle,
          description: _flowLocalizations.developedByStudentsDescription,
        ),
        (
          emoji: '🎉',
          title: _flowLocalizations.moreToComeTitle,
          description: _flowLocalizations.moreToComeDescription,
        ),
      ];

  String get welcomeTitle => _flowLocalizations.welcome;

  String get welcomeSubtitle => _flowLocalizations.fromStudents;

  List<WelcomePageEntry> get entries => _entries;

  String get dataPrivacyIntro => _flowLocalizations.dataPrivacyIntro;

  String get dataPrivacyLabel => _flowLocalizations.dataPrivacyLabel;

  String get buttonText => _flowLocalizations.letsGo;

  void onButtonPressed() {
    GetIt.I.get<LaunchFlowApi>().showedWelcomePage();
    const HomeMainRoute().pushReplacement(_navigatorContext);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _flowLocalizations = context.locals.launchFlow;
    _navigatorContext = context;
  }
}
