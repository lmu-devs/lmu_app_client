import '../model/person_model.dart';

extension PersonModelExtension on PersonModel {
  String formattedTitle() {
    final rawTitle = title;

    if (rawTitle == null || rawTitle.trim().isEmpty) return '';

    var t = rawTitle.trim();

    t = t.replaceAllMapped(
      RegExp(r'\.(\S)'),
      (m) => '. ${m.group(1)}',
    );

    t = t.replaceAll(RegExp(r'\s+'), ' ');

    return t.trim();
  }
}
