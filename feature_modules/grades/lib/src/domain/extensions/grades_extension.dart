import '../model/grade.dart';

extension GradesWeightedAverageExtension on List<Grade> {
  double get weightedAverage {
    if (isEmpty) return 0.0;

    final totalEcts = fold<int>(0, (sum, grade) => sum + grade.ects);
    if (totalEcts == 0) return 0.0;

    final weightedSum = fold<double>(
      0.0,
      (sum, grade) => sum + (grade.grade * grade.ects),
    );

    return weightedSum / totalEcts;
  }

  String get weightedAverageString {
    return weightedAverage.toStringAsFixed(2).replaceAll('.', ',');
  }

  double get totalEcts {
    return fold<int>(0, (sum, grade) => sum + grade.ects).toDouble();
  }
}
