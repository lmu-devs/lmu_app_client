import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'lmu_search_input.dart';

class LmuSearchController extends ValueNotifier<List<LmuSearchInput>> {
  LmuSearchController() : super([]);

  final List<LmuSearchInput> _searchResults = [];
  final List<LmuSearchInput> _searchInputs = [];

  bool _noResult = false;

  bool get noResult => _noResult;

  void clear() {
    _noResult = false;
    value = [];
  }

  set searchInputs(List<LmuSearchInput> searchInputs) {
    _searchInputs.clear();
    _searchInputs.addAll(searchInputs);
  }

  void search(String query) {
    if (query.isEmpty) {
      value = [];
      _noResult = false;
      return;
    }
    _searchResults.clear();
    _searchResults.addAll(
      _searchInputs.where(
        (entry) {
          return entry.title.toLowerCase().contains(query.toLowerCase());
        },
      ),
    );
    _noResult = _searchResults.isEmpty;
    value = List.of(_searchResults);
  }
}
