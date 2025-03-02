import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LmuSearchOverlay extends StatelessWidget {
  const LmuSearchOverlay({
    super.key,
    required this.searchController,
    required this.searchInputs,
    this.bottomWidget,
    this.onCancel,
    this.onClear,
  });

  final LmuSearchController searchController;
  final List<LmuSearchInput> searchInputs;
  final Widget? bottomWidget;
  final VoidCallback? onCancel;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colors.neutralColors.backgroundColors.base,
          border: Border(
            top: BorderSide(
              color: colors.neutralColors.borderColors.seperatorLight,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
        child: Column(
          children: [
            const SizedBox(height: LmuSizes.size_16),
            LmuSearchBar(
              searchController: searchController,
              searchInputs: searchInputs,
              onCancelPressed: onCancel,
              onClearPressed: onClear,
            ),
            const SizedBox(height: LmuSizes.size_16),
            if (bottomWidget != null) SizedBox(width: double.infinity, child: bottomWidget!),
          ],
        ),
      ),
    );
  }
}
