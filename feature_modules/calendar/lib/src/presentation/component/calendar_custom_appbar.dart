import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/calendar_view_type.dart';
import 'view_type_selector.dart';

typedef OnViewTypeSelectedCallback = void Function(CalendarViewType viewType);

//
// Very simple custom AppBar
// Will change drastically in the future
// No need to review this code in detail
//

class CustomCalendarAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomCalendarAppBar({
    super.key,
    required this.currentSelectedDateTimeRange,
    required this.currentViewType,
    this.onChangeToTodayPressed,
    this.onExpandDatePickerPressed,
    required this.isExpanded,
    this.onViewTypeSelected,
    this.onStretchPressed,
    this.onSearchPressed,
    this.onAddCalendarEntryPressed,
    this.onOpenCalendarSettingsPressed,
  });

  final String currentSelectedDateTimeRange;
  final CalendarViewType currentViewType;

  final VoidCallback? onChangeToTodayPressed;
  final VoidCallback? onExpandDatePickerPressed;
  final bool isExpanded;
  final OnViewTypeSelectedCallback? onViewTypeSelected;
  final VoidCallback? onStretchPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onAddCalendarEntryPressed;
  final VoidCallback? onOpenCalendarSettingsPressed;

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
                  onPressed: () => onChangeToTodayPressed,
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuButton(
                  trailingIcon: isExpanded ? LucideIcons.chevron_up : LucideIcons.chevron_down,
                  title: currentSelectedDateTimeRange,
                  onTap: onExpandDatePickerPressed,
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
                  onPressed: () => onAddCalendarEntryPressed,
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuIconButton(
                  icon: LucideIcons.calendar_cog,
                  onPressed: () => onOpenCalendarSettingsPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
