import 'package:flutter/material.dart';
import 'package:widget_driver/widget_driver.dart';

part 'calendar_create_entry_page_driver.g.dart';

@GenerateTestDriver()
class CalendarCreateEntryPageDriver extends WidgetDriver {
  late final TextEditingController _titleController = TextEditingController();

  @TestDriverDefaultValue(null)
  TextEditingController get titleController => _titleController;

  String get largeTitle => "CalendarCreate"; // TODO: Replace with localized title

  @override
  void didInitDriver() {
    super.didInitDriver();
    _titleController.addListener(_onTitleChanged);
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
  }

  void _onTitleChanged() {
    notifyWidget();
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTitleChanged);
    _titleController.dispose();
    super.dispose();
  }
}
