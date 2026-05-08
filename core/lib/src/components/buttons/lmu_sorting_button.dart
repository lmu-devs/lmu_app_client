import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../themes.dart';

class LmuSortingButton<T extends Enum> extends StatelessWidget {
  const LmuSortingButton({
    super.key,
    required this.sortOptionNotifier,
    required this.options,
    required this.titleBuilder,
    required this.iconBuilder,
    required this.onOptionSelected,
  });

  final ValueNotifier<T> sortOptionNotifier;
  final List<T> options;
  final String Function(T option, BuildContext context) titleBuilder;
  final IconData Function(T option) iconBuilder;
  final Future<void> Function(T newOption, BuildContext context) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: sortOptionNotifier,
      builder: (context, activeSortOption, _) {
        return LmuButton(
          title: titleBuilder(activeSortOption, context),
          emphasis: ButtonEmphasis.secondary,
          trailingIcon: LucideIcons.chevron_down,
          onTap: () => _showSortOptionBottomSheet(context),
        );
      },
    );
  }

  void _showSortOptionBottomSheet(BuildContext context) {
    LmuBottomSheet.show(
      context,
      content: _SortOptionBottomSheetContent<T>(
        sortOptionNotifier: sortOptionNotifier,
        options: options,
        titleBuilder: titleBuilder,
        iconBuilder: iconBuilder,
        onOptionSelected: onOptionSelected,
      ),
    );
  }
}

class _SortOptionBottomSheetContent<T extends Enum> extends StatelessWidget {
  const _SortOptionBottomSheetContent({
    required this.sortOptionNotifier,
    required this.options,
    required this.titleBuilder,
    required this.iconBuilder,
    required this.onOptionSelected,
  });

  final ValueNotifier<T> sortOptionNotifier;
  final List<T> options;
  final String Function(T option, BuildContext context) titleBuilder;
  final IconData Function(T option) iconBuilder;
  final Future<void> Function(T newOption, BuildContext context) onOptionSelected;

  Color _getTextColor(BuildContext context, {required bool isActive}) {
    if (isActive) {
      return context.colors.brandColors.textColors.strongColors.base;
    }
    return context.colors.neutralColors.textColors.mediumColors.base;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: sortOptionNotifier,
      builder: (context, activeValue, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...options.map(
                  (sortOption) {
                final isActive = sortOption == activeValue;
                final textColor = _getTextColor(context, isActive: isActive);

                return Column(
                  children: [
                    LmuListItem.base(
                      title: isActive ? titleBuilder(sortOption, context) : null,
                      titleColor: textColor,
                      subtitle: isActive ? null : titleBuilder(sortOption, context),
                      mainContentAlignment: MainContentAlignment.center,
                      leadingArea: LmuIcon(
                        icon: iconBuilder(sortOption),
                        size: LmuIconSizes.medium,
                        color: textColor,
                      ),
                      onTap: () async => await onOptionSelected(sortOption, context),
                    ),
                    if (sortOption != options.last) const SizedBox(height: LmuSizes.size_8),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
