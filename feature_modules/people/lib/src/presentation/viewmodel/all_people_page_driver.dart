import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/people_state.dart';
import '../../domain/model/people.dart';

part 'all_people_page_driver.g.dart';

@GenerateTestDriver()
class AllPeoplePageDriver extends WidgetDriver {
  final PeopleStateService _peopleState = GetIt.I.get<PeopleStateService>();

  late String _allTitle;
  List<People> _peopleItems = [];
  String? _categoryTitle;
  late BuildContext _navigatorContext;
  late PeopleLoadState _loadState;

  List<People>? get _selectedPeople => _peopleState.selectedCategory?.peoples;

  String get title => _categoryTitle ?? _allTitle;
  List<People> get peoples => _peopleItems;
  bool get isLoading => _loadState != PeopleLoadState.success && _loadState != PeopleLoadState.loadingWithCache;

  void _onPeopleStateChanged() {
    final currentState = _peopleState.state.value;
    _loadState = currentState.loadState;
    _peopleItems = _selectedPeople ??
        currentState.peopleCategories.expand((category) => category.peoples).toSet().toList().cast<People>();
    _categoryTitle = _peopleState.selectedCategory?.name;

    notifyWidget();
  }

  void onPeopleCardPressed(People people) {
    print("onPeopleCardPressed wurde aufgerufen mit: ${people.name} (${people.id})");
    _peopleState.selectedCategory = null;
    _peopleState.selectedPersonId = people.id;
    _navigatorContext.go('/studies/people/details/${people.id}');
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    final initialState = _peopleState.state.value;
    _loadState = initialState.loadState;
    _peopleItems = _selectedPeople ??
        initialState.peopleCategories.expand((category) => category.peoples).toSet().toList().cast<People>();
    _categoryTitle = _peopleState.selectedCategory?.name;

    _peopleState.state.addListener(_onPeopleStateChanged);
    _peopleState.getPeople();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _navigatorContext = context;
    _allTitle = "${context.locals.app.all} ${context.locals.peoples.title}";
  }

  @override
  void dispose() {
    _peopleState.state.removeListener(_onPeopleStateChanged);
    super.dispose();
    _peopleState.selectedCategory = null;
  }

  // void onPeopleCardPressed(String personId) {
  //   _navigatorContext.go('/studies/people/details?id=$personId');
  // }
}
