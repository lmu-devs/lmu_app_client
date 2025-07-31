enum Semester { winter24_25, summer25, winter25_26 }

enum SemesterState { finished, inProgress, upcoming }

extension SemesterNameExtension on Semester {
  String get localizedName {
    return switch (this) {
      Semester.winter24_25 => "WINTER 24/25",
      Semester.summer25 => "SUMMER 25",
      Semester.winter25_26 => "WINTER 25/26",
    };
  }
}
