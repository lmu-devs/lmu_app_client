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
    id: '3',
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
  late BuildContext _navigatorContext;

  @override
  void didInitDriver() {
    super.didInitDriver();
    // ID aus dem Zustand auslesen
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _navigatorContext = context;

    final idFromRoute = GoRouterState.of(context).pathParameters['id'];
    print('Extrahierte ID aus Route: $idFromRoute');
    _id = idFromRoute ?? 'unknown';

    // Wenn Person noch nicht geladen wurde
    person = _peopleStateService.state.value.peopleCategories.expand((cat) => cat.peoples).firstWhere(
          (p) => p.id == _id,
          orElse: () => People(
            id: 'unknown',
            name: 'Unbekannt',
            description: 'Keine Beschreibung verfügbar',
            email: '',
            phone: '',
            office: '',
            url: '',
            aliases: const [],
          ),
        );

    print('Geladene Person aus Route: ${person.name}');
    notifyWidget();
  }

  bool isFavorite = false; // Status der Favorisierung

  void toggleFavorite() {
    isFavorite = !isFavorite; // Favorisierungsstatus umschalten
    print('Favorisierungsstatus geändert: $isFavorite');
    notifyWidget(); // UI aktualisieren
  }

  String get name => person.name;
  String get faculty => person.description;
  String get chair => person.office;
  String get email => person.email;
  String get phone => person.phone;
  String get room => person.office;
  void onRoomTap(BuildContext context) {
    print('Raum angeklickt');
  }

  void onWebsiteTap() {
    print('Website angeklickt');
  }
}
