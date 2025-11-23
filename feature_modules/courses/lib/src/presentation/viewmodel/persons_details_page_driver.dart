import 'package:core/localizations.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/person_model.dart';

part 'persons_details_page_driver.g.dart';

const _testPerson = PersonModel(
  firstName: 'John',
  lastName: 'Doe',
  title: 'Dr.',
);

@GenerateTestDriver()
class PersonsDetailsPageDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  PersonsDetailsPageDriver({
    @driverProvidableProperty required this.persons,
  });

  @TestDriverDefaultValue([_testPerson])
  final List<PersonModel> persons;

  late LmuLocalizations _localizations;

  String get pageTitle => _localizations.courses.persons;

  String getFullName(PersonModel person) {
    return [person.title, person.firstName, person.lastName]
        .where((string) => string != null && string.isNotEmpty)
        .join(" ");
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  void didUpdateProvidedProperties({required List<PersonModel> newPersons}) {}
}
