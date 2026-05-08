import 'package:flutter/foundation.dart';

import '../../domain/model/student_id_data.dart';

class GetStudentIdDataUsecase extends ChangeNotifier {
  StudentIdData? _data;

  StudentIdData? get data => _data;

  Future<void> init() async {
    // Hardcoded for now — will be replaced with API call in the future
    _data = const StudentIdData(
      name: 'Raphael Wennmacher',
      email: 'r.wennmacher@campus.lmu.de',
      validUntil: 'Valid until 30.06.2025',
      matrikelnr: '12680165',
      lrzKennung: '72geqeb',
    );
    notifyListeners();
  }
}
