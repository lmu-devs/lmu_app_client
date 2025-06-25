import 'package:shared_api/studies.dart';

class FacultyImpl implements Faculty {
  const FacultyImpl({required this.id, required this.name});

  @override
  final int id;

  @override
  final String name;
}
