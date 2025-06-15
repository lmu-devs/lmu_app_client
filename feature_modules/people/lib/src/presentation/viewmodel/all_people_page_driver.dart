import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/people_state.dart';
import '../../domain/model/people.dart';

part 'all_people_page_driver.g.dart';

@GenerateTestDriver()
class AllPeoplePageDriver extends WidgetDriver {
  final _peopleState = GetIt.I.get<PeopleStateService>();

  late String _allTitle;
  late final List<People> _peopleItems;
  late final String? _categoryTitle;

  List<People>? get _selectedPeople => _peopleState.selectedCategory?.peoples;

  String get title => _categoryTitle ?? _allTitle;
  List<People> get peoples => _peopleItems;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _peopleItems = _selectedPeople ??
        _peopleState.state.value.peopleCategories
            .expand((category) => category.peoples)
            .toSet()
            .toList()
            .cast<People>();
    _categoryTitle = _peopleState.selectedCategory?.name;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _allTitle = "${context.locals.app.all} ${context.locals.peoples.title}";
  }

  @override
  void dispose() {
    super.dispose();
    _peopleState.selectedCategory = null;
  }
}
