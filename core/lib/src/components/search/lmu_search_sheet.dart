import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class LmuSearchSheetController {
  LmuSearchSheetState? _state;

  void _attach(LmuSearchSheetState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  void openExtended(bool focusSearch) {
    _state?._openExtended(focusSearch);
  }

  void close() {
    _state?._close();
  }
}

class LmuSearchSheet extends StatefulWidget {
  const LmuSearchSheet({
    super.key,
    required this.searchEntries,
    this.belowSearchContent,
    this.controller,
  });

  final List<LmuSearchEntry> searchEntries;
  final Widget? belowSearchContent;
  final LmuSearchSheetController? controller;

  @override
  LmuSearchSheetState createState() => LmuSearchSheetState();
}

class LmuSearchSheetState extends State<LmuSearchSheet> {
  late DraggableScrollableController _sheetController;

  late final LmuSearchController _searchController;
  late final List<LmuSearchInput> _searchInputs;

  late TextEditingController _textEditingController;
  late FocusNode _searchFocusNode;

  late ValueNotifier<bool> _isSearchActiveNotifier;
  late ValueNotifier<List<LmuSearchEntry>> _searchEntriesNotifier;

  late final double _minSize;
  late final double _baseSize;
  late final double _maxSize;

  List<LmuSearchEntry> get _searchEntries => widget.searchEntries;
  Widget? get _belowSearchContent => widget.belowSearchContent;

  @override
  void initState() {
    super.initState();

    //TODO: Dynamic min/base sizes
    _minSize = 0.105; // 1px == 0.0013125
    _baseSize = 0.35;
    _maxSize = 0.9;

    _sheetController = DraggableScrollableController();
    _sheetController.addListener(_onScroll);
    _searchEntriesNotifier = ValueNotifier<List<LmuSearchEntry>>(_searchEntries);

    _searchController = LmuSearchController();

    _searchController.addListener(_mapSearchInputsToResults);

    _textEditingController = TextEditingController();
    _searchInputs = _searchEntries.map((entry) {
      return LmuSearchInput(
        title: entry.title,
        id: entry.title,
        tags: entry.additionalTags,
      );
    }).toList();

    _searchFocusNode = FocusNode();
    _isSearchActiveNotifier = ValueNotifier<bool>(false);

    widget.controller?._attach(this);
  }

  void _mapSearchInputsToResults() {
    final searchValue = _searchController.value;
    if (searchValue.isEmpty && !_searchController.noResult) {
      _searchEntriesNotifier.value = _searchEntries;
      return;
    }
    _searchEntriesNotifier.value = searchValue.map((input) {
      final match = _searchEntries.firstWhere((entry) => entry.title == input.title);
      return match;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_mapSearchInputsToResults);
    _searchController.dispose();
    _searchFocusNode.removeListener(_onScroll);
    _textEditingController.dispose();
    _searchFocusNode.dispose();
    _searchEntriesNotifier.dispose();
    _sheetController.dispose();

    widget.controller?._detach();
    super.dispose();
  }

  void _onScroll() {
    // final currentExtent = _sheetController.size;
    // if (currentExtent <= (_baseSize + 0.001) && _isSearchActiveNotifier.value) {
    //   _isSearchActiveNotifier.value = false;
    //   if (_searchFocusNode.hasFocus) {
    //     _searchFocusNode.unfocus();
    //   }
    // }
  }

  void _openExtended(bool focusSearch) async {
    await _sheetController.animateTo(
      _maxSize,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    if (focusSearch) {
      _isSearchActiveNotifier.value = true;
      final searchLength = _textEditingController.text.length;
      if (searchLength > 0) {
        _searchFocusNode.requestFocus();
        _textEditingController.selection = TextSelection(baseOffset: 0, extentOffset: searchLength);
      }
    }
  }

  void _close() {
    _sheetController.animateTo(
      _minSize,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: _baseSize,
      minChildSize: _minSize,
      maxChildSize: _maxSize,
      snapSizes: [_minSize, _baseSize, _maxSize],
      snap: true,
      snapAnimationDuration: const Duration(milliseconds: 150),
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colors.neutralColors.backgroundColors.base,
            border: Border(
              top: BorderSide(
                color: colors.neutralColors.borderColors.seperatorDark,
                width: 0.5,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(LmuSizes.size_24),
              topRight: Radius.circular(LmuSizes.size_24),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: LmuSizes.size_24),
              BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: LmuSizes.size_64),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(LmuSizes.size_16),
              child: Column(
                children: [
                  LmuSearchBar(
                    searchController: _searchController,
                    searchInputs: _searchInputs,
                    focusNode: _searchFocusNode,
                    onOpen: () {
                      _isSearchActiveNotifier.value = true;
                      _sheetController.animateTo(
                        _maxSize,
                        duration: const Duration(milliseconds: 300),
                        curve: LmuAnimations.fastSmooth,
                      );
                    },
                    onCancelPressed: () {
                      _isSearchActiveNotifier.value = false;
                      _sheetController.animateTo(
                        _baseSize,
                        duration: const Duration(milliseconds: 300),
                        curve: LmuAnimations.fastSmooth,
                      );
                    },
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  ValueListenableBuilder(
                    valueListenable: _isSearchActiveNotifier,
                    builder: (context, isSearchActive, child) {
                      if (!isSearchActive) return _belowSearchContent ?? const SizedBox.shrink();

                      return ValueListenableBuilder(
                        valueListenable: _searchEntriesNotifier,
                        builder: (context, searchEntries, child) {
                          if (searchEntries.isEmpty) return const SizedBox.shrink();

                          return LmuContentTile(
                            content: searchEntries
                                .map(
                                  (searchEntry) => LmuListItem.base(
                                    leadingArea: searchEntry.icon != null
                                        ? LmuIcon(
                                            icon: searchEntry.icon!,
                                            color: searchEntry.iconColor ??
                                                colors.neutralColors.textColors.strongColors.base,
                                            size: LmuIconSizes.medium,
                                          )
                                        : null,
                                    title: searchEntry.title,
                                    subtitle: searchEntry.subtitle,
                                    onTap: () {
                                      _sheetController.animateTo(
                                        _baseSize,
                                        duration: const Duration(milliseconds: 300),
                                        curve: LmuAnimations.fastSmooth,
                                      );
                                      searchEntry.onTap();
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
