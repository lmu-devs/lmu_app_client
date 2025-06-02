import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/people_state.dart';
import '../../domain/model/people.dart';

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

  List<bool> favoriteStates = [false, false];

  void toggleFavorite(int index) {
    favoriteStates[index] = !favoriteStates[index];
    notifyWidget(); // ✔️ Hier ist notifyWidget erlaubt
  }

  void onPeopleCardPressed(BuildContext context, String id, String title, String description) {
    GoRouter.of(context).push(
      '/people/details',
      extra: {
        'id': id,
        'title': title,
        'description': description,
      },
    );
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
