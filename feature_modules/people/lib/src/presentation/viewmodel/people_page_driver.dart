import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/people.dart';
import '../../application/state//people_state.dart';

part 'people_page_driver.g.dart';

@GenerateTestDriver()
class PeoplePageDriver extends WidgetDriver {
  final _peopleStateService = GetIt.I.get<PeopleStateService>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late People? _people;
  late PeopleLoadState _peopleLoadState;

  int _count = 0;

  bool get isLoading => _peopleLoadState != PeopleLoadState.success;

  String get largeTitle => "People"; // TODO: Replace with localized title

  String get peopleId => _people?.id ?? '';

  String get title => _people?.name ?? '';

  String get description => _count.toString();

  void onPeopleCardPressed() {
    _count += 1;
    notifyWidget();
  }

  void _onPeopleStateChanged() {
    final state = _peopleStateService.stateNotifier.value;
    _peopleLoadState = state.loadState;
    _people = state.people;
    notifyWidget();

    if (_peopleLoadState == PeopleLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _peopleStateService.getPeople(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    final state = _peopleStateService.stateNotifier.value;
    _peopleLoadState = state.loadState;
    _people = state.people;
    _peopleStateService.stateNotifier.addListener(_onPeopleStateChanged);
    _peopleStateService.getPeople();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _peopleStateService.stateNotifier.removeListener(_onPeopleStateChanged);
    super.dispose();
  }
}
