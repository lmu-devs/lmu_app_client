import 'package:core/localizations.dart';

enum GradeSemester {
  winter2020,
  summer2021,
  winter2021,
  summer2022,
  winter2022,
  summer2023,
  winter2023,
  summer2024,
  winter2024,
  summer2025,
  winter2025,
  summer2026,
}

extension GradeSemesterExtension on GradeSemester {
  String toJsonString() {
    return switch (this) {
      GradeSemester.winter2020 => 'winter2020',
      GradeSemester.summer2021 => 'summer2021',
      GradeSemester.winter2021 => 'winter2021',
      GradeSemester.summer2022 => 'summer2022',
      GradeSemester.winter2022 => 'winter2022',
      GradeSemester.summer2023 => 'summer2023',
      GradeSemester.winter2023 => 'winter2023',
      GradeSemester.summer2024 => 'summer2024',
      GradeSemester.winter2024 => 'winter2024',
      GradeSemester.summer2025 => 'summer2025',
      GradeSemester.winter2025 => 'winter2025',
      GradeSemester.summer2026 => 'summer2026',
    };
  }

  static GradeSemester fromJsonString(String semester) {
    return switch (semester) {
      'winter2020' => GradeSemester.winter2020,
      'summer2021' => GradeSemester.summer2021,
      'winter2021' => GradeSemester.winter2021,
      'summer2022' => GradeSemester.summer2022,
      'winter2022' => GradeSemester.winter2022,
      'summer2023' => GradeSemester.summer2023,
      'winter2023' => GradeSemester.winter2023,
      'summer2024' => GradeSemester.summer2024,
      'winter2024' => GradeSemester.winter2024,
      'summer2025' => GradeSemester.summer2025,
      'winter2025' => GradeSemester.winter2025,
      'summer2026' => GradeSemester.summer2026,
      _ => throw Exception('Unknown semester string: $semester'),
    };
  }

  String get semesterYears {
    return switch (this) {
      GradeSemester.winter2020 => '20/21',
      GradeSemester.summer2021 => '21',
      GradeSemester.winter2021 => '21/22',
      GradeSemester.summer2022 => '22',
      GradeSemester.winter2022 => '22/23',
      GradeSemester.summer2023 => '23',
      GradeSemester.winter2023 => '23/24',
      GradeSemester.summer2024 => '24',
      GradeSemester.winter2024 => '24/25',
      GradeSemester.summer2025 => '25',
      GradeSemester.winter2025 => '25/26',
      GradeSemester.summer2026 => '26',
    };
  }

  String localizedName(GradesLocatizations locatizations) {
    return switch (this) {
      GradeSemester.winter2020 => "${locatizations.winter} $semesterYears",
      GradeSemester.summer2021 => "${locatizations.summer} $semesterYears",
      GradeSemester.winter2021 => "${locatizations.winter} $semesterYears",
      GradeSemester.summer2022 => "${locatizations.summer} $semesterYears",
      GradeSemester.winter2022 => "${locatizations.winter} $semesterYears",
      GradeSemester.summer2023 => "${locatizations.summer} $semesterYears",
      GradeSemester.winter2023 => "${locatizations.winter} $semesterYears",
      GradeSemester.summer2024 => "${locatizations.summer} $semesterYears",
      GradeSemester.winter2024 => "${locatizations.winter} $semesterYears",
      GradeSemester.summer2025 => "${locatizations.summer} $semesterYears",
      GradeSemester.winter2025 => "${locatizations.winter} $semesterYears",
      GradeSemester.summer2026 => "${locatizations.summer} $semesterYears",
    };
  }
}
