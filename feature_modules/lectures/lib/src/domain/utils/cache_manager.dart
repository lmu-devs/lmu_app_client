import 'dart:collection';

/// Generic cache manager with TTL and size limits
class CacheManager<K, V> {
  CacheManager({
    this.maxSize = 100,
    this.defaultTtl = const Duration(hours: 1),
  });

  final int maxSize;
  final Duration defaultTtl;

  final LinkedHashMap<K, _CacheEntry<V>> _cache = LinkedHashMap<K, _CacheEntry<V>>();

  /// Get value from cache
  V? get(K key) {
    final entry = _cache[key];
    if (entry == null) return null;

    // Check if expired
    if (entry.isExpired) {
      _cache.remove(key);
      return null;
    }

    // Move to end (LRU)
    _cache.remove(key);
    _cache[key] = entry;
    return entry.value;
  }

  /// Put value in cache
  void put(K key, V value, {Duration? ttl}) {
    // Remove if exists
    _cache.remove(key);

    // Add new entry
    _cache[key] = _CacheEntry(
      value,
      DateTime.now().add(ttl ?? defaultTtl),
    );

    // Enforce size limit
    _enforceSizeLimit();
  }

  /// Check if key exists and is not expired
  bool containsKey(K key) {
    final entry = _cache[key];
    if (entry == null) return false;
    
    if (entry.isExpired) {
      _cache.remove(key);
      return false;
    }
    
    return true;
  }

  /// Remove specific key
  void remove(K key) {
    _cache.remove(key);
  }

  /// Clear all entries
  void clear() {
    _cache.clear();
  }

  /// Get cache size
  int get size => _cache.length;

  /// Check if cache is empty
  bool get isEmpty => _cache.isEmpty;

  /// Get all keys
  Iterable<K> get keys => _cache.keys;

  /// Clean expired entries
  void cleanExpired() {
    final now = DateTime.now();
    _cache.removeWhere((key, entry) => entry.expiresAt.isBefore(now));
  }

  /// Enforce size limit using LRU eviction
  void _enforceSizeLimit() {
    while (_cache.length > maxSize) {
      _cache.remove(_cache.keys.first);
    }
  }
}

/// Cache entry with expiration time
class _CacheEntry<V> {
  _CacheEntry(this.value, this.expiresAt);

  final V value;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

/// Specialized cache manager for lectures
class LecturesCacheManager {
  LecturesCacheManager({
    this.maxFaculties = 10,
    this.maxLecturesPerFaculty = 1000,
    this.cacheTtl = const Duration(hours: 2),
  });

  final int maxFaculties;
  final int maxLecturesPerFaculty;
  final Duration cacheTtl;

  final CacheManager<int, List<dynamic>> _facultyCache = CacheManager<int, List<dynamic>>(
    maxSize: 10,
    defaultTtl: const Duration(hours: 2),
  );

  /// Get cached lectures for faculty
  List<dynamic>? getLecturesForFaculty(int facultyId) {
    return _facultyCache.get(facultyId);
  }

  /// Cache lectures for faculty
  void cacheLecturesForFaculty(int facultyId, List<dynamic> lectures) {
    _facultyCache.put(facultyId, lectures, ttl: cacheTtl);
  }

  /// Check if faculty has cached data
  bool hasCachedDataForFaculty(int facultyId) {
    return _facultyCache.containsKey(facultyId);
  }

  /// Remove cached data for faculty
  void removeFacultyData(int facultyId) {
    _facultyCache.remove(facultyId);
  }

  /// Clear all cached data
  void clearAll() {
    _facultyCache.clear();
  }

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    return {
      'cachedFaculties': _facultyCache.size,
      'maxFaculties': maxFaculties,
      'cacheTtl': cacheTtl.inMinutes,
    };
  }

  /// Clean expired entries
  void cleanExpired() {
    _facultyCache.cleanExpired();
  }
}
