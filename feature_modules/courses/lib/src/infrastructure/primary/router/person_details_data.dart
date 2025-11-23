import 'package:core_routes/cinema.dart';
import 'package:core_routes/courses.dart';

import '../../../domain/model/person_model.dart';

class PersonDetailsData extends RPersonDetailsData {
  const PersonDetailsData({
    required this.persons,
  });

  final List<PersonModel> persons;

  @override
  List<Object?> get props => [
        persons,
      ];
}
