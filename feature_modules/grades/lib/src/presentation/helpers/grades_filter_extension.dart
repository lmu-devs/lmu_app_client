import '../../domain/model/grade.dart';

extension GradesFilterExtension on List<Grade> {
  List<Grade> get activeGrades {
    return where((grade) => grade.isActive).toList();
  }

  double get weightedAverage {
    if (isEmpty) return 0.0;

    final gradesWithValue = where((grade) => grade.grade != null).toList();
    if (gradesWithValue.isEmpty) return 0.0;

    final totalEctsWithGrade = gradesWithValue.fold<int>(0, (sum, grade) => sum + grade.ects);
    if (totalEctsWithGrade == 0) return 0.0;

    final weightedSum = gradesWithValue.fold<double>(
      0.0,
      (sum, grade) => sum + (grade.grade! * grade.ects),
    );

    return weightedSum / totalEctsWithGrade;
  }

  double get totalEcts {
    return fold<int>(0, (sum, grade) => sum + grade.ects).toDouble();
  }
}
