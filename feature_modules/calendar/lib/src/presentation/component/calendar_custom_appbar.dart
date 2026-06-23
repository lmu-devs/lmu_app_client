import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../domain/model/calendar_view_type.dart';
import '../../domain/model/helper/date_time_formatter.dart';
import 'view_type_selector.dart';

typedef OnViewTypeSelectedCallback = void Function(CalendarViewType viewType);

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
    this.isLoading,
    this.hasError,
  });

  final DateTimeRange currentSelectedDateTimeRange;
  final CalendarViewType currentViewType;

  final VoidCallback? onChangeToTodayPressed;
  final VoidCallback? onExpandDatePickerPressed;
  final bool isExpanded;
  final OnViewTypeSelectedCallback? onViewTypeSelected;
  final VoidCallback? onStretchPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onAddCalendarEntryPressed;
  final VoidCallback? onOpenCalendarSettingsPressed;

  final bool? isLoading;
  final bool? hasError;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  bool get _isDisabled => isLoading == true || hasError == true;

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
                  isDisabled: isLoading == true || hasError == true,
                  icon: LucideIcons.calendar,
                  onPressed: () => onChangeToTodayPressed?.call(),
                ),
                const SizedBox(width: LmuSizes.size_8),
                GestureDetector(
                  onTap: isLoading == true || hasError == true ? null : onExpandDatePickerPressed,
                  child: Row(
                    children: [
                      LmuText.body(
                        _calculateTitleFormat(currentSelectedDateTimeRange, currentViewType),
                        weight: FontWeight.bold,
                        color: _isDisabled ? context.colors.neutralColors.textColors.mediumColors.disabled : null,
                      ),
                      const SizedBox(width: LmuSizes.size_4),
                      LmuIcon(
                        icon: isExpanded && !_isDisabled ? LucideIcons.chevron_up : LucideIcons.chevron_down,
                        size: LmuIconSizes.mediumSmall,
                        color: _isDisabled ? context.colors.neutralColors.textColors.mediumColors.disabled : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Right side elements
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ViewTypeSelector(
                  context: context,
                  initialView: currentViewType,
                  onSelected: (viewType) => onViewTypeSelected?.call(viewType),
                ),
                LmuIconButton(
                  icon: LucideIcons.search,
                  onPressed: () => onSearchPressed?.call(),
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuIconButton(
                  icon: LucideIcons.plus,
                  onPressed: () => onAddCalendarEntryPressed?.call(),
                ),
                const SizedBox(width: LmuSizes.size_8),
                LmuIconButton(
                  icon: LucideIcons.calendar_cog,
                  onPressed: () => onOpenCalendarSettingsPressed?.call(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _calculateTitleFormat(DateTimeRange<DateTime> currentSelectedDateTimeRange, CalendarViewType currentViewType) {
    switch (currentViewType) {
      case CalendarViewType.day:
        return DateTimeFormatter.formatShorterDate(currentSelectedDateTimeRange.start, withYearIfDifferent: true);
      case CalendarViewType.month || CalendarViewType.list:
        return DateTimeFormatter.formatMonthName(currentSelectedDateTimeRange.start, withYearIfDifferent: true);
      default:
        return DateTimeFormatter.formatShorterDate(currentSelectedDateTimeRange.start, withYearIfDifferent: true);
    }
  }
}
