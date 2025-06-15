import 'package:get_it/get_it.dart';
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
    description: 'Test Description',
    email: 'test@example.com',
    phone: '123456789',
    office: 'Test Office',
    url: 'https://example.com',
    aliases: const [],
  ))
  late final People person;

  late String _id;

  @override
  void didInitDriver() {
    super.didInitDriver();
    person =
        _peopleStateService.state.value.peopleCategories.expand((cat) => cat.peoples).firstWhere((p) => p.id == _id);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    //_allTitle = "${context.locals.app.all} ${context.locals.peoples.title}";
  }

  String get name => person.name;
  String get faculty => person.description;
  String get chair => person.description;
  String get email => person.email ?? 'Nicht verfügbar';
  String get phone => person.phone ?? 'Nicht verfügbar';
  String get room => person.office ?? 'Nicht angegeben';
  String get website => person.url ?? '';

  void onRoomTap(BuildContext context) {
    print("Room tapped: $room");
  }

  void onWebsiteTap() {
    print("Website tapped: $website");
  }
}
