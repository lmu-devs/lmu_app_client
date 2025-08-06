import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/calendar_view_type.dart';
import 'view_type_selector.dart';

typedef OnViewTypeSelectedCallback = void Function(CalendarViewType viewType);

class CustomCalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomCalendarAppBar({
    super.key,
    required this.currentSelectedMonth,
    required this.currentViewType,
    this.onCalendarPressed,
    this.onMonthPressed,
    this.onViewTypeSelected,
    this.onStretchPressed,
    this.onSearchPressed,
    this.onAddPressed,
    this.onSyncPressed,
  });

  final String currentSelectedMonth;
  final CalendarViewType currentViewType;

  final VoidCallback? onCalendarPressed;
  final VoidCallback? onMonthPressed;
  final OnViewTypeSelectedCallback? onViewTypeSelected;
  final VoidCallback? onStretchPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onAddPressed;
  final VoidCallback? onSyncPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 10,
      title: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side elements
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LmuIconButton(
                  icon: LucideIcons.calendar,
                  onPressed: () => onCalendarPressed,
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuButton(
                  trailingIcon: LucideIcons.chevron_down,
                  title: currentSelectedMonth,
                  onTap: onMonthPressed,
                  emphasis: ButtonEmphasis.secondary,
                ),
              ],
            ),
            // Right side elements
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ViewTypeSelector(
                  context: context,
                  initialView: currentViewType,
                  onSelected: (viewType) => onViewTypeSelected?.call(viewType),
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuIconButton(
                  icon: LucideIcons.search,
                  onPressed: () => onSearchPressed,
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuIconButton(
                  icon: LucideIcons.plus,
                  onPressed: () => onAddPressed,
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuIconButton(
                  icon: LucideIcons.calendar_sync,
                  onPressed: () => onSyncPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
