import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/services.dart';

class ExploreMapBottomSheet extends StatefulWidget {
  const ExploreMapBottomSheet({super.key});

  static const _filters = ["Alle", "Mensen", "Gebäude", "Kinos", "Bibliotheken"];

  @override
  State<ExploreMapBottomSheet> createState() => _ExploreMapBottomSheetState();
}

class _ExploreMapBottomSheetState extends State<ExploreMapBottomSheet> {
  late final DraggableScrollableController _draggableScrollableController;

  final _sheetService = GetIt.I<ExploreSheetService>();

  @override
  void initState() {
    super.initState();

    _draggableScrollableController = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.17,
      initialChildSize: 0.17,
      controller: _draggableScrollableController,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.neutralColors.backgroundColors.base,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: LmuSizes.size_16, left: LmuSizes.size_16, right: LmuSizes.size_16),
                child: LmuSearchInputField(
                  controller: _sheetService.searchController,
                  focusNode: _sheetService.searchFocusNode,
                ),
              ),
              const SizedBox(height: LmuSizes.size_12),
              LmuButtonRow(
                buttons: ExploreMapBottomSheet._filters.map((filter) {
                  return LmuButton(
                    title: filter,
                    emphasis: ButtonEmphasis.secondary,
                    onTap: () {
                      _draggableScrollableController.animateTo(
                        0.9,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: LmuSizes.size_16),
            ],
          ),
        );
      },
    );
  }
}
