import 'package:collection/collection.dart';
import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/people_state.dart';
import '../../domain/model/people.dart';
import '../../domain/model/people_category.dart';

part 'people_page_driver.g.dart';

@GenerateTestDriver()
class PeoplePageDriver extends WidgetDriver {
  final _peopleState = GetIt.I.get<PeopleStateService>();

  late BuildContext _navigatorContext;
  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late List<PeopleCategory> _peopleCategories;
  late PeopleLoadState _peopleLoadState;

  List<People> get favorites =>
      _peopleCategories.expand((category) => category.peoples).where((person) => person.isFavorite).toList();

  bool get isLoading =>
      _peopleLoadState != PeopleLoadState.success && _peopleLoadState != PeopleLoadState.loadingWithCache;

  String get allPeopleTitle => _appLocalizations.showAll;
  String get allPeopleCount => _peopleCategories.expand((category) => category.peoples).toSet().length.toString();

  List<PeopleCategory> get peopleCategories {
    final facultyGroups = _peopleCategories
        .expand((category) => category.peoples)
        .where((person) => person.faculty.isNotEmpty)
        .groupListsBy((person) => person.faculty);

    final List<PeopleCategory> regularFaculties = [];
    PeopleCategory? crossFaculty;
    int index = 1;

    final sortedEntries = facultyGroups.entries.toList()
      ..sort((a, b) => _cleanFacultyName(a.key).compareTo(_cleanFacultyName(b.key)));

    for (final entry in sortedEntries) {
      final originalName = entry.key;
      final isCrossFaculty = originalName.toLowerCase().contains('fakultätsübergreifend');
      final cleanedName = _cleanFacultyName(originalName);

      final category = PeopleCategory(
        name: cleanedName,
        description: isCrossFaculty ? 'Fakultätsübergreifend' : 'Fakultät ${index++}',
        emoji: '🎓',
        peoples: entry.value,
      );

      if (isCrossFaculty) {
        crossFaculty = category;
      } else {
        regularFaculties.add(category);
      }
    }

    if (crossFaculty != null) {
      regularFaculties.add(crossFaculty); // am Ende anhängen
    }

    return regularFaculties;
  }

  String _cleanFacultyName(String name) {
    final lower = name.toLowerCase().trim();
    String cleaned = name.trim();

    // Prefixe entfernen
    const prefixPatterns = [
      'fakultät für ',
      'fakultät ',
      'faculty of ',
      'faculty',
      'fakultätsübergreifende',
    ];

    for (final pattern in prefixPatterns) {
      if (lower.startsWith(pattern)) {
        cleaned = cleaned.substring(pattern.length).trim();
        break;
      }
    }

    // Suffixe entfernen
    const suffixPatterns = [
      ' fakultät',
      ' faculty',
    ];

    for (final pattern in suffixPatterns) {
      if (cleaned.toLowerCase().endsWith(pattern)) {
        cleaned = cleaned.substring(0, cleaned.length - pattern.length).trim();
        break;
      }
    }

    return cleaned;
  }

  void onAllPeoplePressed() {
    _peopleState.selectedCategory = null;
    _navigatorContext.go('/studies/people/all');
  }

  void onPeopleCardPressed(String personId) {
    _peopleState.selectedCategory = null;
    _navigatorContext.go('/studies/people/details/$personId');
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
