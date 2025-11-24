import 'dart:convert';

import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/create_calendar_entry_usecase.dart';
import '../../application/usecase/get_entries_by_date_usecase.dart';
import '../../domain/model/calendar_entry.dart';
import '../../domain/model/calendar_rule.dart';
import '../../domain/model/event_type.dart';
import '../../domain/model/frequency.dart';

part 'calendar_create_entry_page_driver.g.dart';

@GenerateTestDriver()
class CalendarCreateEntryPageDriver extends WidgetDriver {
  // Inject UseCases
  final CreateCalendarEntryUsecase _createUsecase = GetIt.I.get<CreateCalendarEntryUsecase>();
  final GetCalendarEntriesByDateUsecase _getEntriesUsecase = GetIt.I.get<GetCalendarEntriesByDateUsecase>();

  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _locationController = TextEditingController();
  late final TextEditingController _linkController = TextEditingController();
  late final TextEditingController _descriptionController = TextEditingController();

  DateTime _startTime = DateTime.now().add(const Duration(hours: 1));
  DateTime _endTime = DateTime.now().add(const Duration(hours: 2));
  bool _allDay = false;
  Color _selectedColor = const Color(0xFFFFA500);
  Frequency? _recurrence = Frequency.once;
  int _intervall = 1;
  DateTime _untilTime = DateTime.now().add(const Duration(hours: 3));
  LocationModel? _location;
  String _notification = "Keine";
  bool _isSaving = false; // Add loading state

  // --- Getters for UI ---
  @TestDriverDefaultValue(null)
  TextEditingController get titleController => _titleController;

  @TestDriverDefaultValue(null)
  TextEditingController get locationController => _locationController;

  @TestDriverDefaultValue(null)
  LocationModel? get location => _location;

  @TestDriverDefaultValue(null)
  TextEditingController get linkController => _linkController;

  @TestDriverDefaultValue(null)
  TextEditingController get descriptionController => _descriptionController;

  @TestDriverDefaultValue('Neuer Termin')
  String get pageTitle => "Neuer Termin";

  @TestDriverDefaultValue(false)
  bool get isAllDay => _allDay;

  @TestDriverDefaultValue(Colors.orange)
  Color get selectedColor => _selectedColor;

  @TestDriverDefaultValue(Frequency.once)
  Frequency? get recurrence => _recurrence;

  @TestDriverDefaultValue(1)
  int get intervall => _intervall;

  @TestDriverDefaultValue(null)
  DateTime get untilTime => _untilTime;

  @TestDriverDefaultValue("Keine")
  String get notificationText => _notification;

  @TestDriverDefaultValue(null)
  DateTime get startTime => _startTime;

  @TestDriverDefaultValue(null)
  DateTime get endTime => _endTime;

  @TestDriverDefaultValue(false)
  bool get isSaving => _isSaving;

  // --- Setters / Actions ---

  void toggleAllDay(bool value) {
    _allDay = value;
    notifyWidget();
  }

  void setColor(Color color) {
    _selectedColor = color;
    notifyWidget();
  }

  void setRecurrence(Frequency? value) {
    _recurrence = value;
    notifyWidget();
  }

  void setNotification(String value) {
    _notification = value;
    notifyWidget();
  }

  void setStartTime(DateTime date) {
    _startTime = date;
    // Ensure end time is after start time
    if (_endTime.isBefore(_startTime)) {
      _endTime = _startTime.add(const Duration(hours: 1));
    }
    notifyWidget();
  }

  void setEndTime(DateTime date) {
    _endTime = date;
    notifyWidget();
  }

  void setUntilTime(DateTime date) {
    _untilTime = date.endOfDay;
    notifyWidget();
  }

  void setIntervall(int value) {
    _intervall = value;
    notifyWidget();
  }

  void setLocation(LocationModel? value) {
    _location = value;
    notifyWidget();
  }

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

  Future<void> saveEntry(BuildContext context) async {
    if (_titleController.text.isEmpty) {
      LmuToast.show(
        context: context,
        message: "Bitte einen Titel eingeben",
        type: ToastType.error,
      );
      return;
    }
    if (_endTime.isBefore(_startTime)) {
      LmuToast.show(
        context: context,
        message: "Die Endzeit muss nach der Startzeit liegen.",
        type: ToastType.error,
      );
      return;
    }
    if (_endTime.isAfter(_untilTime)) {
      LmuToast.show(
        context: context,
        message: "Das Enddatum der Wiederholung muss nach dem Endzeitpunkt des Termins liegen.",
        type: ToastType.error,
      );
      return;
    }

    _isSaving = true;
    notifyWidget();

    final newEntry = CalendarEntry(
      id: 'test-philipp-1', // Empty ID, backend generates it
      title: _titleController.text,
      eventType: EventType.lecture, // TODO: user selection
      startTime: _allDay ? _startTime.startOfDay : _startTime,
      endTime: _allDay ? _endTime.endOfDay : _endTime,
      allDay: _allDay,
      color: _selectedColor,
      onlineLink: _linkController.text.isNotEmpty ? _linkController.text : null,
      description: _descriptionController.text,
      accessScope: 0,
      location: _location,
      rule: _recurrence != null
          ? CalendarRule(frequency: _recurrence!, interval: _intervall, untilTime: _untilTime)
          : const CalendarRule(frequency: Frequency.once, interval: 1),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      // 1. Execute Creation UseCase
      await _createUsecase.execute(newEntry);

      // 2. Refresh the List UseCase
      // This ensures that when we pop back, the list reloads from API (since repo invalidated cache)
      await _getEntriesUsecase.refresh();

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Fehler beim Speichern: $e")),
        );
      }
    } finally {
      _isSaving = false;
      notifyWidget();
    }
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _titleController.addListener(notifyWidget);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _linkController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
