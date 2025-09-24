/// Service for managing semester configuration and calculations
class SemesterConfigService {
  const SemesterConfigService();

  /// Get current semester based on current date
  /// Falls back to hardcoded defaults (Winter 2025) since backend isn't ready yet
  SemesterInfo get currentSemester {
    // TODO: Remove hardcoded defaults when backend supports dynamic semesters
    return SemesterInfo(
      termId: 1, // Winter semester
      year: 2025,
      displayName: 'Winter 24/25',
      isCurrent: true,
    );

    // Future implementation when backend is ready:
    // final now = DateTime.now();
    // return _getSemesterForDate(now);
  }

  /// Get semester for a specific date
  SemesterInfo getSemesterForDate(DateTime date) {
    return _getSemesterForDate(date);
  }

  /// Get all available semesters (current and next few)
  /// Currently limited since backend only supports Winter 2025
  List<SemesterInfo> get availableSemesters {
    // TODO: Expand when backend supports multiple semesters
    return [
      SemesterInfo(
        termId: 1,
        year: 2025,
        displayName: 'Winter 24/25',
        isCurrent: true,
      ),
      // Future semesters when backend is ready:
      // SemesterInfo(termId: 2, year: 2025, displayName: 'Summer 25', isCurrent: false),
      // SemesterInfo(termId: 1, year: 2026, displayName: 'Winter 25/26', isCurrent: false),
    ];
  }

  /// Get semester info for a specific term and year
  SemesterInfo getSemesterInfo(int termId, int year) {
    return SemesterInfo(
      termId: termId,
      year: year,
      displayName: _getSemesterDisplayName(termId, year),
      isCurrent: _isCurrentSemester(termId, year),
    );
  }

  /// Calculate semester based on date
  SemesterInfo _getSemesterForDate(DateTime date) {
    final year = date.year;
    final month = date.month;

    // Winter semester: October to March (termId = 1)
    // Summer semester: April to September (termId = 2)
    if (month >= 10 || month <= 3) {
      // Winter semester starts in October
      final winterYear = month >= 10 ? year : year - 1;
      return SemesterInfo(
        termId: 1,
        year: winterYear,
        displayName: _getSemesterDisplayName(1, winterYear),
        isCurrent: true,
      );
    } else {
      // Summer semester
      return SemesterInfo(
        termId: 2,
        year: year,
        displayName: _getSemesterDisplayName(2, year),
        isCurrent: true,
      );
    }
  }

  /// Generate display name for semester
  String _getSemesterDisplayName(int termId, int year) {
    final termName = termId == 1 ? 'Winter' : 'Summer';
    final shortYear = year.toString().substring(2);
    final nextYear = (year + 1).toString().substring(2);

    if (termId == 1) {
      return '$termName $shortYear/$nextYear';
    } else {
      return '$termName $shortYear';
    }
  }

  /// Check if given term/year is current semester
  bool _isCurrentSemester(int termId, int year) {
    final current = currentSemester;
    return current.termId == termId && current.year == year;
  }
}

/// Data class for semester information
class SemesterInfo {
  const SemesterInfo({
    required this.termId,
    required this.year,
    required this.displayName,
    required this.isCurrent,
  });

  final int termId;
  final int year;
  final String displayName;
  final bool isCurrent;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SemesterInfo && other.termId == termId && other.year == year;
  }

  @override
  int get hashCode => termId.hashCode ^ year.hashCode;

  @override
  String toString() => 'SemesterInfo(termId: $termId, year: $year, displayName: $displayName)';
}
