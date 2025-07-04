import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/studies.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_people_usecase.dart';
import '../../domain/model/people.dart';

part 'people_overview_driver.g.dart';

@GenerateTestDriver()
class PeopleOverviewDriver extends WidgetDriver implements _$DriverProvidedProperties {
  PeopleOverviewDriver({
    @driverProvidableProperty required int facultyId,
  }) : _facultyId = facultyId;

  late int _facultyId;
  int get facultyId => _facultyId;

  final _usecase = GetIt.I.get<GetPeopleUsecase>();
  final _facultiesApi = GetIt.I.get<FacultiesApi>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  List<Faculty> get selectedFaculties => _facultiesApi.selectedFaculties;
  List<Faculty> get allFaculties => _facultiesApi.allFaculties;

  bool get isLoading => _usecase.loadState != PeopleLoadState.success;

    String get largeTitle {
    final faculty = allFaculties.firstWhere((f) => f.id == facultyId);
    return faculty.name;
  }

  List<People> get people => _usecase.data;
  
  // Filer und Sortierung
  List<People> get filteredPeople {
    var filtered = people;
    
    // Alphabetisch sortieren
    filtered.sort((a, b) => a.name.compareTo(b.name));
    
    return filtered;
  }
  
  // Gruppierung nach Alphabet
  Map<String, List<People>> get groupedPeople {
    final grouped = <String, List<People>>{};
    
    for (final person in filteredPeople) {
      final firstLetter = person.name.isNotEmpty ? person.name[0].toUpperCase() : '#';
      if (!grouped.containsKey(firstLetter)) {
        grouped[firstLetter] = [];
      }
      grouped[firstLetter]!.add(person);
    }
    
    return grouped;
  }

  void onPersonPressed(People person) {
    // TODO: Navigate to person details or implement person interaction
    print('Person pressed: ${person.name}');
  }

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == PeopleLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _usecase.load(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _usecase.load();
    _facultiesApi.selectedFacultiesStream.listen((_) => notifyWidget());
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void didUpdateProvidedProperties({
    required int newFacultyId,
  }) {
    _facultyId = newFacultyId;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
