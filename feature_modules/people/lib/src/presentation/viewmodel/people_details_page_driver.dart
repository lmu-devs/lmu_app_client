import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';
import 'package:core_routes/people.dart';

import '../../application/usecase/get_people_usecase.dart';
import '../../domain/model/people.dart';

part 'people_details_page_driver.g.dart';

@GenerateTestDriver()
class PeopleDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  PeopleDetailsPageDriver({
    @driverProvidableProperty required int personId,
  }) : _personId = personId;

  late int _personId;
  int get personId => _personId;

  final _usecase = GetIt.I.get<GetPeopleUsecase>();

  People? get person => _usecase.data.where((p) => p.id == personId).firstOrNull;

  String get largeTitle {
    final person = _usecase.data.firstWhere((p) => p.id == personId);
    return person.name;
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    if (_usecase.data.isEmpty) {
      _usecase.load();
    }
  }

  void _onStateChanged() {
    notifyWidget();
  }

  @override
  void didUpdateProvidedProperties({
    required int newPersonId,
  }) {
    _personId = newPersonId;
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
