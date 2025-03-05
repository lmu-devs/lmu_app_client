class Course {
  final String name;
  final double? grade;
  final int ECTS;

  Course({required this.name, this.grade, required this.ECTS});
}

double? calculateAverageGrade(List<Course> courses) {
  double totalWeightedGrades = 0;
  int totalECTSWithGrade = 0;
  int totalECTSEarned = 0;

  for (var course in courses) {
    totalECTSEarned += course.ECTS;

    if (course.grade != null) {
      totalWeightedGrades += course.grade! * course.ECTS;
      totalECTSWithGrade += course.ECTS;
    }
  }

  print("Total ECTS Earned: $totalECTSEarned / 120");

  return totalECTSWithGrade > 0 ? totalWeightedGrades / totalECTSWithGrade : null;
}

void main() {
  List<Course> courses = [
    Course(name: "ALL", grade: 1.46, ECTS: 60),
    Course(name: "NOCREDITS", grade: null, ECTS: 12),
    Course(name: "OMM", grade: 1.3, ECTS: 6),
    Course(name: "HCS", grade: 1.7, ECTS: 6),
    Course(name: "APP", grade: 1.0, ECTS: 6),
    Course(name: "MASTERARBEIT", grade: 1.7, ECTS: 30),
  ];

  double? averageGrade = calculateAverageGrade(courses);

  if (averageGrade != null) {
    print("Average grade: ${averageGrade.toStringAsFixed(2)}");
  } else {
    print("No grades available to calculate an average.");
  }
}
