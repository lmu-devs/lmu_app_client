import 'package:core/localizations.dart';
import 'package:core_routes/home.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';
import 'package:widget_driver/widget_driver.dart';

part 'welcome_page_driver.g.dart';

typedef WelcomePageEntry = ({String emoji, String title, String description});

@GenerateTestDriver()
class WelcomePageDriver extends WidgetDriver {
  late LaunchFlowLocatizations _flowLocatizations;
  late BuildContext _navigatorContext;

  List<WelcomePageEntry> get _entries => <WelcomePageEntry>[
        (
          emoji: '🤝',
          title: _flowLocatizations.campusCompanionTitle,
          description: _flowLocatizations.campusCompanionDescription,
        ),
        (
          emoji: '🧑‍💻',
          title: _flowLocatizations.developedByStudentsTitle,
          description: _flowLocatizations.developedByStudentsDescription,
        ),
        (
          emoji: '🎉',
          title: _flowLocatizations.moreToComeTitle,
          description: _flowLocatizations.moreToComeDescription,
        ),
      ];

  String get welcomeTitle => _flowLocatizations.welcome;

  String get welcomeSubtitle => _flowLocatizations.fromStudents;

  List<WelcomePageEntry> get entries => _entries;

  String get buttonText => _flowLocatizations.letsGo;

  void onButtonPressed() {
    GetIt.I.get<LaunchFlowApi>().showedWelcomePage();
    const HomeMainRoute().pushReplacement(_navigatorContext);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _flowLocatizations = context.locals.launchFlow;
    _navigatorContext = context;
  }
}
