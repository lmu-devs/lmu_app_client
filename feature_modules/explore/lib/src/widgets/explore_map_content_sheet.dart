import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../services/explore_map_service.dart';

class ExploreMapContentSheetController {
  ExploreMapContentSheetState? _state;

  void _attach(ExploreMapContentSheetState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  void open(ExploreLocation location, {bool fromSearch = false}) {
    _state?._open(location, fromSearch: fromSearch);
  }

  void close() {
    _state?._close();
  }
}

class ExploreMapContentSheet extends StatefulWidget {
  const ExploreMapContentSheet({
    super.key,
    this.controller,
    required this.onClose,
  });

  final ExploreMapContentSheetController? controller;
  final void Function(bool) onClose;

  @override
  ExploreMapContentSheetState createState() => ExploreMapContentSheetState();
}

class ExploreMapContentSheetState extends State<ExploreMapContentSheet> {
  late DraggableScrollableController _sheetController;

  ExploreLocation? _location;
  bool? _fromSearch;

  late final double _minSize;
  late final double _baseSize;
  late final double _maxSize;

  @override
  void initState() {
    super.initState();

    //TODO: Dynamic min/base sizes
    _minSize = 0; // 1px == 0.0013125
    _baseSize = 0.20;
    _maxSize = 0.9;

    _sheetController = DraggableScrollableController();
    _sheetController.addListener(_onScroll);

    widget.controller?._attach(this);
  }

  @override
  void dispose() {
    _sheetController.dispose();
    widget.controller?._detach();
    super.dispose();
  }

  void _onScroll() {}

  void _open(ExploreLocation location, {bool fromSearch = false}) {
    setState(() {
      _location = location;
      _fromSearch = fromSearch;
    });
    _sheetController.animateTo(
      _baseSize,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _close() async {
    await _sheetController.animateTo(
      _minSize,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    setState(() {
      _location = null;
      _fromSearch = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: _minSize,
      minChildSize: _minSize,
      maxChildSize: _maxSize,
      snapSizes: [_baseSize, _maxSize],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: LmuText.h1(
                        _location?.name,
                      )),
                      GestureDetector(
                        onTap: () {
                          widget.onClose(_fromSearch ?? false);
                          _close();
                          GetIt.I<ExploreMapService>().deselectMarker();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(LmuSizes.size_4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.neutralColors.backgroundColors.mediumColors.base,
                          ),
                          child: LmuIcon(
                            icon: LucideIcons.x,
                            size: LmuIconSizes.medium,
                          ),
                        ),
                      ),
                    ],
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
