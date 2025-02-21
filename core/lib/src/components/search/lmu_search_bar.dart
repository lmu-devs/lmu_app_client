import 'package:core/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LmuSearchBar extends StatefulWidget {
  const LmuSearchBar({
    super.key,
    required this.searchController,
    required this.searchInputs,
    this.textEditingController,
    this.focusNode,
    this.onOpen,
    this.onClearPressed,
    this.onCancelPressed,
  });

  final LmuSearchController searchController;
  final List<LmuSearchInput> searchInputs;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final void Function()? onOpen;
  final void Function()? onClearPressed;
  final void Function()? onCancelPressed;

  @override
  State<LmuSearchBar> createState() => _LmuSearchBarState();
}

class _LmuSearchBarState extends State<LmuSearchBar> {
  LmuSearchController get _searchController => widget.searchController;
  @override
  void initState() {
    _searchController.searchInputs = widget.searchInputs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LmuSearchInputField(
      controller: widget.textEditingController ?? TextEditingController(),
      focusNode: widget.focusNode ?? FocusNode(),
      onTap: (inputState) {
        if (inputState == InputState.base) {
          widget.onOpen?.call();
        }
      },
      onChanged: (value) => _searchController.search(value),
      onClearPressed: () {
        widget.onClearPressed?.call();
        _searchController.clear();
      },
      onCancelPressed: () {
        _searchController.clear();
        widget.onCancelPressed?.call();
      },
    );
  }
}
