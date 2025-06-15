import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/people_state.dart';
import '../../domain/model/people_category.dart';

part 'people_page_driver.g.dart';

@GenerateTestDriver()
class PeoplePageDriver extends WidgetDriver {
  final _peopleState = GetIt.I.get<PeopleStateService>();

  late BuildContext _navigatorContext;
  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late List<PeopleCategory> _peopleCategories;
  //late People? _people;
  late PeopleLoadState _peopleLoadState;

  bool get isLoading =>
      _peopleLoadState != PeopleLoadState.success && _peopleLoadState != PeopleLoadState.loadingWithCache;

  String get allPeopleTitle => _appLocalizations.showAll;
  String get allPeopleCount =>
      _peopleCategories.expand((peopleCategory) => peopleCategory.peoples).toSet().length.toString();

  List<PeopleCategory> get peopleCategories => _peopleCategories;

  void onAllPeoplePressed() {
    _peopleState.selectedCategory = null;
    const AllPeopleRoute().go(_navigatorContext);
    //const PeopleDetailsRoute().go(_navigatorContext);
  }

  void onPeopleCardPressed(BuildContext context, String id) {
    const DetailsPeopleRoute(context, id).go(_navigatorContext);
  }

  void _onPeopleStateChanged() {
    final newState = _peopleState.state.value;
    _peopleLoadState = newState.loadState;
    _peopleCategories = _peopleState.state.value.peopleCategories;

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
      onActionPressed: () => _peopleState.getPeople(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    final initialState = _peopleState.state.value;
    _peopleLoadState = initialState.loadState;
    _peopleCategories = initialState.peopleCategories;
    _peopleState.state.addListener(_onPeopleStateChanged);
    _peopleState.getPeople();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _navigatorContext = context;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _peopleState.state.removeListener(_onPeopleStateChanged);
    super.dispose();
  }
}
