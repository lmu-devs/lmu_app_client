import '../models/faculty.dart';

abstract class FacultiesApi {
  /// All faculties available to the user.
  List<Faculty> get allFaculties;

  /// The list of faculties currently selected by the user
  List<Faculty> get selectedFaculties;

  /// A stream that emits updates whenever [selectedFaculties] changes.
  Stream<List<Faculty>> get selectedFacultiesStream;
}
