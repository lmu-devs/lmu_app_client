import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/people_state.dart';
import '../../domain/model/people.dart';

part 'people_details_page_driver.g.dart';

@GenerateTestDriver()
class PeopleDetailsPageDriver extends WidgetDriver {
  final _peopleStateService = GetIt.I.get<PeopleStateService>();

  @TestDriverDefaultValue(People(
    id: 'test-id',
    name: 'Test Person',
    profileUrl: 'https://example.com',
    basicInfo: BasicInfo(
      lastName: 'Test',
      gender: 'male',
      firstName: 'Person',
    ),
    faculty: 'Test Faculty',
    roles: [],
    courses: [],
  ))
  late final People person;

  String? _id;
  BuildContext? _context;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _peopleStateService.state.addListener(_onPeopleStateChanged);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _context = context;
    _initializePerson();
  }

  void _onPeopleStateChanged() {
    if (_context != null) {
      _initializePerson();
    }
  }

  void _initializePerson() {
    if (_context == null) return;

    // Get the ID from the route parameters
    final params = GoRouterState.of(_context!).uri.queryParameters;
    _id = params['id'];

    if (_id == null || _id!.isEmpty) {
      throw Exception('No person ID provided in route parameters');
    }

    try {
      final foundPerson =
          _peopleStateService.state.value.peopleCategories.expand((cat) => cat.peoples).firstWhere((p) => p.id == _id);

      person = foundPerson;
      notifyWidget();
    } catch (e) {
      print('Error finding person with ID $_id: $e');
    }
  }

  String get name =>
      '${person.basicInfo.title ?? ''} ${person.basicInfo.firstName} ${person.basicInfo.lastName} ${person.basicInfo.nameSuffix ?? ''}'
          .trim();
  String get faculty => person.faculty;
  String get role => person.roles.isNotEmpty ? person.roles.first.role : '';
  String get email => person.basicInfo.note ?? '';
  String get phone => person.basicInfo.officeHours ?? '';
  String get room => person.basicInfo.status ?? '';
  String get website => person.profileUrl;
  String get academicDegree => person.basicInfo.academicDegree ?? '';
  String get employmentStatus => person.basicInfo.employmentStatus ?? '';

  void onRoomTap(BuildContext context) {
    print("Room tapped: $room");
  }

  void onWebsiteTap() {
    print("Website tapped: $website");
  }

  @override
  void dispose() {
    _peopleStateService.state.removeListener(_onPeopleStateChanged);
    super.dispose();
  }
}
