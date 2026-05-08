const List<double> availableGrades = [1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0];

const double maxEctsValue = 220.0;

double? parseEcts(String text) {
  final value = double.tryParse(text.replaceAll(',', '.'));
  if (value == null || value <= 0 || value > maxEctsValue) return null;
  return value;
}
