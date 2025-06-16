import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
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

  List<PeopleCategory> get peopleCategories {
    // Group people by faculty
    final facultyGroups = _peopleCategories
        .expand((category) => category.peoples)
        .where((person) => person.faculty.isNotEmpty)
        .groupListsBy((person) => person.faculty);

    return facultyGroups.entries.map((entry) {
      return PeopleCategory(
        name: entry.key,
        description: '${entry.value.length} people',
        emoji: '🎓',
        peoples: entry.value,
      );
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  void onAllPeoplePressed() {
    _peopleState.selectedCategory = null;
    _navigatorContext.go('/studies/people/all');
  }

  void onPeopleCardPressed(String personId) {
    _peopleState.selectedCategory = null;
    _navigatorContext.go('/studies/people/details/$personId');
    //const PeopleDetailsRoute().go(_navigatorContext);
  }

  void onFacultyPressed(PeopleCategory faculty) {
    _peopleState.selectedCategory = faculty;
    _navigatorContext.go('/studies/people/all');
  }

  void _onPeopleStateChanged() {
    final newState = _peopleState.state.value;
    _peopleLoadState = newState.loadState;
    _peopleCategories = newState.peopleCategories;

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
