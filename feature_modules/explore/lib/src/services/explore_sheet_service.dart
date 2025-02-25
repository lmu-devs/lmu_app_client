import 'package:flutter/material.dart';

class ExploreSheetService {
  void init() {
    return;
  }

  DraggableScrollableController get draggableScrollableController => _draggableScrollableController;
  TextEditingController get searchController => _searchController;
  FocusNode get searchFocusNode => _searchFocusNode;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final DraggableScrollableController _draggableScrollableController = DraggableScrollableController();

  void expand() {
    _draggableScrollableController.animateTo(
      0.9,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void collapse() {
    _draggableScrollableController.animateTo(
      0.17,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
