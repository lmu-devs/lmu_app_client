// ============================================================================
// FUTURE IMPROVEMENT: Pagination Support
// ============================================================================
// The following classes are implemented but currently UNUSED.
// They are prepared for future UI integration when pagination controls are added.
// Currently, the UI loads all lectures at once without pagination.
// ============================================================================

/// Pagination configuration for lecture lists
class PaginationConfig {
  const PaginationConfig({
    this.page = 1,
    this.pageSize = 20,
    this.maxPageSize = 100,
  });

  final int page;
  final int pageSize;
  final int maxPageSize;

  /// Get offset for pagination
  int get offset => (page - 1) * pageSize;

  /// Create next page configuration
  PaginationConfig nextPage() => PaginationConfig(
        page: page + 1,
        pageSize: pageSize,
        maxPageSize: maxPageSize,
      );

  /// Create previous page configuration
  PaginationConfig previousPage() => PaginationConfig(
        page: page > 1 ? page - 1 : 1,
        pageSize: pageSize,
        maxPageSize: maxPageSize,
      );

  /// Create configuration with specific page
  PaginationConfig withPage(int newPage) => PaginationConfig(
        page: newPage,
        pageSize: pageSize,
        maxPageSize: maxPageSize,
      );

  /// Create configuration with specific page size
  PaginationConfig withPageSize(int newPageSize) => PaginationConfig(
        page: page,
        pageSize: newPageSize.clamp(1, maxPageSize),
        maxPageSize: maxPageSize,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginationConfig &&
        other.page == page &&
        other.pageSize == pageSize &&
        other.maxPageSize == maxPageSize;
  }

  @override
  int get hashCode => page.hashCode ^ pageSize.hashCode ^ maxPageSize.hashCode;

  @override
  String toString() => 'PaginationConfig(page: $page, pageSize: $pageSize)';
}

/// Paginated result containing data and pagination metadata
class PaginatedResult<T> {
  const PaginatedResult({
    required this.data,
    required this.pagination,
    required this.hasMore,
    required this.totalCount,
  });

  final List<T> data;
  final PaginationConfig pagination;
  final bool hasMore;
  final int totalCount;

  /// Get current page number
  int get currentPage => pagination.page;

  /// Get total pages
  int get totalPages => (totalCount / pagination.pageSize).ceil();

  /// Check if there's a next page
  bool get hasNextPage => hasMore;

  /// Check if there's a previous page
  bool get hasPreviousPage => currentPage > 1;

  @override
  String toString() => 'PaginatedResult(data: ${data.length} items, page: $currentPage/$totalPages)';
}
