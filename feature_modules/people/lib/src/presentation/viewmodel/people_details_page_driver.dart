import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/people.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/people_state.dart';
import '../../domain/model/people.dart'; // Importiere das People-Modell
import '../../domain/model/people_category.dart';

part 'people_details_page_driver.g.dart';

@GenerateTestDriver()
class PeopleDetailsPageDriver extends WidgetDriver {
  final _peopleStateService = GetIt.I.get<PeopleStateService>();
  late final People person;

  @override
  void didInitDriver() {
    super.didInitDriver();
    final id = (widget as PeopleDetailsPage).id;
    // Hole die Person anhand der ID aus dem State
    person =
        _peopleStateService.state.value.peopleCategories.expand((cat) => cat.peoples).firstWhere((p) => p.id == id);
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
