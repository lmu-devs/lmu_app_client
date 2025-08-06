import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../../domain/model/calendar_view_type.dart';

class ViewTypeSelector extends StatefulWidget {
  const ViewTypeSelector({
    super.key,
    required this.initialView,
    required this.onSelected,
    required this.context,
  });

  final CalendarViewType initialView;
  final ValueChanged<CalendarViewType> onSelected;
  final BuildContext context;

  @override
  State<ViewTypeSelector> createState() => _ViewTypeSelectorState();
}

class _ViewTypeSelectorState extends State<ViewTypeSelector> {
  late CalendarViewType _selectedView;

  @override
  void initState() {
    super.initState();
    _selectedView = widget.initialView;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CalendarViewType>(
      initialValue: _selectedView,
      // Only call onSelected if the item is not disabled
      onSelected: (CalendarViewType newValue) {
        if (!newValue.disabled) {
          setState(() {
            _selectedView = newValue;
          });
          widget.onSelected(newValue);
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LmuRadiusSizes.mediumLarge),
      ),
      itemBuilder: (BuildContext context) {
        return CalendarViewType.types.map((CalendarViewType viewType) {
          // Check if the item is disabled
          if (viewType.disabled) {
            return PopupMenuItem<CalendarViewType>(
              enabled: false,
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_20, vertical: LmuSizes.size_6),
              child: Row(
                children: [
                  Icon(viewType.icon, color: Colors.grey),
                  const SizedBox(width: LmuSizes.size_8),
                  Text(
                    viewType.name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            return PopupMenuItem<CalendarViewType>(
              value: viewType,
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_20, vertical: LmuSizes.size_6),
              child: Row(
                children: [
                  Icon(viewType.icon),
                  const SizedBox(width: LmuSizes.size_8),
                  Text(viewType.name),
                ],
              ),
            );
          }
        }).toList();
      },
      icon: Container(
        padding: const EdgeInsets.all(LmuSizes.size_8),
        decoration: BoxDecoration(
          color: widget.context.colors.neutralColors.backgroundColors.mediumColors.base,
          borderRadius: BorderRadius.circular(LmuSizes.size_8),
        ),
        child: LmuIcon(
          icon: _selectedView.icon,
          size: LmuIconSizes.mediumSmall * MediaQuery.of(context).textScaler.textScaleFactor,
        ),
      ),
    );
  }
}
