import 'package:core/core_services.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/launch_flow.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_release_notes_usecase.dart';
import '../../domain/interface/release_notes_repository_interface.dart';
import '../../domain/model/release_notes_highlight.dart';

part 'release_notes_page_driver.g.dart';

@GenerateTestDriver()
class ReleaseNotesPageDriver extends WidgetDriver {
  late LaunchFlowLocatizations _flowLocalizations;
  late BuildContext _navigatorContext;

  final _getReleaseNotesUsecase = GetIt.I.get<GetReleaseNotesUsecase>();
  final _appVersion = GetIt.I.get<SystemInfoService>().systemInfo.appVersion;

  final _repository = GetIt.I.get<ReleaseNotesRepositoryInterface>();

  String get relaseTitle => _flowLocalizations.releaseNotesTitle;

  String get releaseDescription => _flowLocalizations.version(_appVersion);

  String get buttonText => _flowLocalizations.letsGo;

  List<ReleaseNotesHighlight> get releaseNotes => _getReleaseNotesUsecase.releaseNotesHighlights;

  bool get showPrivacyPolicy => _getReleaseNotesUsecase.showPrivacyPolicy;

  void onButtonPressed() {
    _repository.markReleaseNotesAsShown();
    final launchFlowApi = GetIt.I.get<LaunchFlowApi>();
    launchFlowApi.continueFlow(_navigatorContext);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _flowLocalizations = context.locals.launchFlow;
    _navigatorContext = context;
  }
}
