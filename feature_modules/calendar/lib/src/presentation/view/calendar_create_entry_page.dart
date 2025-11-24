import 'dart:convert';

import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/frequency.dart';
import '../../domain/model/helper/date_time_formatter.dart';
import '../viewmodel/calendar_create_entry_page_driver.dart';
import 'location_search_sheet.dart';

class CalendarCreateEntryPage extends DrivableWidget<CalendarCreateEntryPageDriver> {
  CalendarCreateEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return LmuScaffold(
      appBar: LmuAppBarData(
        largeTitle: driver.pageTitle,
        leadingAction: LeadingAction.back,
        trailingWidgets: [
          LmuButton(
            onTap: () => driver.saveEntry(context),
            title: "Speichern",
            emphasis: ButtonEmphasis.link,
            state: driver.isSaving
                ? ButtonState.loading
                : driver.titleController.text.isEmpty
                    ? ButtonState.disabled
                    : ButtonState.enabled,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  const SizedBox(height: LmuSizes.size_16),
                  LmuInputField(
                    controller: driver.titleController,
                    hintText: 'Titel',
                    isMultiline: false,
                    maxLines: 1,
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  LmuInputField(
                    controller: driver.locationController,
                    hintText: "Standort",
                    isMultiline: false,
                    onTap: () async {
                      final selectedLocation = await showModalBottomSheet<LocationModel>(
                        context: context,
                        builder: (context) => LocationSearchSheet(onSelected: (location) {
                          Navigator.of(context).pop(location);
                        }),
                      );
                      if (selectedLocation != null) {
                        driver.setLocation(selectedLocation);
                        driver.locationController.text = selectedLocation.address;
                      }
                    },
                  ),
                  const SizedBox(height: LmuSizes.size_8),
                  LmuInputField(
                    controller: driver.linkController,
                    hintText: 'Online-Link (Optional)',
                    isMultiline: false,
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                ],
              ),
            ),

            // --- Section 3: Color Picker ---
            _ColorPickerRow(
              selectedColor: driver.selectedColor,
              onColorSelected: driver.setColor,
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_2, horizontal: LmuSizes.size_12),
                    decoration: BoxDecoration(
                      color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                      borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
                    ),
                    child: LmuListItem.action(
                      title: 'Ganztägig',
                      actionType: LmuListItemAction.toggle,
                      initialValue: driver.isAllDay,
                      onChange: (value) {
                        LmuVibrations.secondary();
                        driver.toggleAllDay(value);
                      },
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  _DateTimeRow(
                    label: "von",
                    date: driver.startTime,
                    showTime: !driver.isAllDay,
                    onDateTap: () => _pickDate(context, driver.startTime, driver.setStartTime),
                    onTimeTap: () => _pickTime(context, driver.startTime, driver.setStartTime),
                  ),
                  const SizedBox(height: LmuSizes.size_8),
                  // End Time
                  _DateTimeRow(
                    label: "bis",
                    date: driver.endTime,
                    showTime: !driver.isAllDay,
                    onDateTap: () => _pickDate(context, driver.endTime, driver.setEndTime),
                    onTimeTap: () => _pickTime(context, driver.endTime, driver.setEndTime),
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_2, horizontal: LmuSizes.size_12),
                    decoration: BoxDecoration(
                      color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                      borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
                    ),
                    child: Column(
                      children: [
                        LmuListItem.action(
                          title: "Wiederholen",
                          actionType: LmuListItemAction.chevron,
                          trailingTitle: driver.recurrence != null
                              ? Frequency.labelMap.entries.firstWhere((entry) => entry.value == driver.recurrence).key
                              : Frequency.once.label,
                          onTap: () => _showRecurrenceSheet(context),
                        ),
                        driver.recurrence?.label != Frequency.once.label
                            ? LmuListItem.action(
                                title: "Intervall",
                                actionType: LmuListItemAction.chevron,
                                trailingTitle: formatIntervallLabel(driver.recurrence!, driver.intervall),
                                onTap: () => _showIntervallSheet(context, driver.recurrence!),
                              )
                            : const SizedBox.shrink(),
                        driver.recurrence?.label != Frequency.once.label
                            ? LmuListItem.action(
                                title: "Wiederholt bis",
                                actionType: LmuListItemAction.chevron,
                                trailingTitle: DateFormat('dd.MM.yyyy').format(driver.untilTime),
                                onTap: () => _pickDate(context, driver.untilTime, driver.setUntilTime),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_2, horizontal: LmuSizes.size_12),
                    decoration: BoxDecoration(
                      color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                      borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
                    ),
                    child: LmuListItem.action(
                      title: "Benachrichtigung",
                      actionType: LmuListItemAction.chevron,
                      trailingTitle: driver.notificationText,
                      onTap: () => _showNotificationSheet(context),
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_16),
                  Container(
                    height: 120,
                    padding: const EdgeInsets.all(4.0),
                    child: LmuInputField(
                      controller: driver.descriptionController,
                      hintText: 'Beschreibung',
                      isMultiline: true,
                      maxLines: 5,
                    ),
                  ),
                  const SizedBox(height: LmuSizes.size_32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationSearchSheet(BuildContext context) {
    LmuBottomSheet.show(
      context,
      content: LocationSearchSheet(
        onSelected: (location) {
          driver.setLocation(location);
        },
      ),
    );
  }

  // --- Location loocup ---

  Future<LocationModel?> geocodeAddress(String address) async {
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$address&format=json&limit=1');

    final response = await http.get(url, headers: {'User-Agent': 'YourAppName/1.0 (your@email.com)'});

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    if (data.isEmpty) return null;

    return LocationModel(
      address: address,
      latitude: double.parse(data[0]['lat']),
      longitude: double.parse(data[0]['lon']),
    );
  }

  // --- Helpers for Date Picking ---

  Future<void> _pickDate(BuildContext context, DateTime current, Function(DateTime) onSaved) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      // Preserve the time of the current selection
      final newDateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
        current.hour,
        current.minute,
      );
      onSaved(newDateTime);
    }
  }

  Future<void> _pickTime(BuildContext context, DateTime current, Function(DateTime) onSaved) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
    );
    if (picked != null) {
      final newDateTime = DateTime(
        current.year,
        current.month,
        current.day,
        picked.hour,
        picked.minute,
      );
      onSaved(newDateTime);
    }
  }

  // --- Bottom Sheets ---

  void _showRecurrenceSheet(BuildContext context) {
    final options = Frequency.labelMap;

    LmuBottomSheet.show(
      context,
      content: Builder(
        builder: (sheetContext) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...options.entries.map((entry) => ListTile(
                    title: Text(
                      entry.key,
                      style: TextStyle(
                        color: driver.recurrence == entry.value
                            ? sheetContext.colors.brandColors.textColors.strongColors.base
                            : sheetContext.colors.neutralColors.textColors.mediumColors.base,
                      ),
                    ),
                    trailing: driver.recurrence == entry.value
                        ? Icon(LucideIcons.check, color: sheetContext.colors.brandColors.textColors.strongColors.base)
                        : null,
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      if (driver.recurrence == entry.value) return;
                      LmuVibrations.secondary();
                      driver.setRecurrence(entry.value);
                    },
                  )),
            ],
          );
        },
      ),
    );
  }

  String formatIntervallLabel(Frequency frequency, int intervall) {
    switch (frequency) {
      case Frequency.daily:
        return intervall == 1 ? "Jeden Tag" : "Jeden $intervall. Tag";

      case Frequency.weekly:
        return intervall == 1 ? "Jede Woche" : "Alle $intervall Wochen";

      case Frequency.monthly:
        if (intervall == 1) return "Jeden Monat";
        if (intervall == 3) return "Jedes Vierteljahr";
        if (intervall == 6) return "Jedes halbe Jahr";
        return "Alle $intervall Monate";

      case Frequency.yearly:
        return intervall == 1 ? "Jedes Jahr" : "Alle $intervall Jahre";

      case Frequency.once:
        return "Einmalig";
    }
  }

  Map<Frequency, List<int>> intervallOptions = {
    Frequency.daily: [1, 2, 3, 4, 5, 6],
    Frequency.weekly: [1, 2, 3],
    Frequency.monthly: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    Frequency.yearly: [1, 2, 3, 4],
  };

  void _showIntervallSheet(BuildContext context, Frequency frequency) {
    final List<int> values = intervallOptions[frequency]!;

    final options = {
      for (final v in values) formatIntervallLabel(frequency, v): v,
    };

    LmuBottomSheet.show(
      context,
      content: Builder(
        builder: (sheetContext) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...options.entries.map((entry) => ListTile(
                    title: Text(
                      entry.key,
                      style: TextStyle(
                        color: driver.intervall == entry.value
                            ? sheetContext.colors.brandColors.textColors.strongColors.base
                            : sheetContext.colors.neutralColors.textColors.mediumColors.base,
                      ),
                    ),
                    trailing: driver.intervall == entry.value
                        ? Icon(LucideIcons.check, color: sheetContext.colors.brandColors.textColors.strongColors.base)
                        : null,
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      if (driver.intervall == entry.value) return;
                      LmuVibrations.secondary();
                      driver.setIntervall(entry.value);
                    },
                  )),
            ],
          );
        },
      ),
    );
  }

  void _showNotificationSheet(BuildContext context) {
    final options = ["Keine", "Zum Startzeitpunkt", "10 Min. vorher", "1 Stunde vorher", "1 Tag vorher"];

    LmuToast.show(
      context: context,
      message: "Feature coming soon!",
      type: ToastType.warning,
    );

    return;

    LmuBottomSheet.show(context, content: Builder(builder: (sheetContext) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...options.map((option) => ListTile(
                title: Text(option,
                    style: TextStyle(
                        color: driver.notificationText == option
                            ? context.colors.brandColors.textColors.strongColors.base
                            : context.colors.neutralColors.textColors.mediumColors.base)),
                trailing: driver.notificationText == option
                    ? Icon(LucideIcons.check, color: context.colors.brandColors.textColors.strongColors.base)
                    : null,
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  if (driver.notificationText == option) return;
                  LmuVibrations.secondary();
                  driver.setNotification(option);
                },
              )),
        ],
      );
    }));
  }

  @override
  WidgetDriverProvider<CalendarCreateEntryPageDriver> get driverProvider => $CalendarCreateEntryPageDriverProvider();
}

// --- Local Helper Widgets ---

class _ColorPickerRow extends StatelessWidget {
  const _ColorPickerRow({
    required this.selectedColor,
    required this.onColorSelected,
  });

  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  @override
  Widget build(BuildContext context) {
    final colors = [
      context.colors.customColors.colorColors.amber,
      context.colors.customColors.colorColors.pink,
      context.colors.customColors.colorColors.red,
      context.colors.customColors.colorColors.purple,
      context.colors.customColors.colorColors.blue,
      context.colors.customColors.colorColors.teal,
      context.colors.customColors.colorColors.green,
      context.colors.customColors.colorColors.lime,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: LmuSizes.size_16,
          ),
          ...colors.map((color) {
            final isSelected = selectedColor.value == color.value;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_6),
              child: GestureDetector(
                onTap: () => {
                  LmuVibrations.primary(),
                  onColorSelected(color),
                },
                child: Container(
                  width: LmuSizes.size_48,
                  height: LmuSizes.size_48,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(
                            color: context.colors.neutralColors.textColors.nonInvertableColors.base,
                            width: LmuSizes.size_4)
                        : null,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(
            width: LmuSizes.size_16,
          ),
        ],
      ),
    );
  }
}

class _DateTimeRow extends StatelessWidget {
  final String label;
  final DateTime date;
  final bool showTime;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;

  const _DateTimeRow({
    required this.label,
    required this.date,
    required this.showTime,
    required this.onDateTap,
    required this.onTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dateString = DateTimeFormatter.formatShorterDate(date);
    final timeString = DateTimeFormatter.formatTimeForLocale(date);

    return Row(
      children: [
        SizedBox(
            width: LmuSizes.size_32,
            child: LmuText(
              label,
              color: colors.neutralColors.textColors.mediumColors.base,
            )),
        const SizedBox(width: LmuSizes.size_8),
        // Date
        Expanded(
          child: GestureDetector(
            onTap: onDateTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_16, horizontal: LmuSizes.size_20),
              decoration: BoxDecoration(
                color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LmuIcon(icon: LucideIcons.calendar, size: LmuIconSizes.mediumSmall),
                  const SizedBox(width: LmuSizes.size_8),
                  LmuText(
                    dateString,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Time
        if (showTime) ...[
          const SizedBox(width: LmuSizes.size_8),
          GestureDetector(
            onTap: onTimeTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: LmuSizes.size_16, horizontal: LmuSizes.size_32),
              decoration: BoxDecoration(
                color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                borderRadius: BorderRadius.circular(LmuRadiusSizes.medium),
              ),
              child: Row(
                children: [
                  const LmuIcon(icon: LucideIcons.clock, size: LmuIconSizes.mediumSmall),
                  const SizedBox(width: LmuSizes.size_8),
                  LmuText(
                    timeString,
                  ),
                ],
              ),
            ),
          ),
        ]
      ],
    );
  }
}
