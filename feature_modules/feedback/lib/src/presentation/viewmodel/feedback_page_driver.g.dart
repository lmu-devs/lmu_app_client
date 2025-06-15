// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_page_driver.dart';

// **************************************************************************
// WidgetDriverGenerator
// **************************************************************************

// coverage:ignore-file

// This file was generated with widget_driver_generator version "1.3.3"

class _$TestFeedbackPageDriver extends TestDriver implements FeedbackPageDriver {
  @override
  TextEditingController get textEditingController => _TestTextEditingController();

  @override
  String get largeTitle => ' ';

  @override
  String get description => ' ';

  @override
  String get inputHint => ' ';

  @override
  bool get showEmojiPicker => false;

  @override
  String get buttonTitle => ' ';

  @override
  ButtonState get buttonState => ButtonState.values[0];

  @override
  void onEmojiSelected(EmojiFeedback feedback) {}

  @override
  Future<void> onSendFeedbackButtonTap() {
    return Future.value();
  }

  @override
  void didInitDriver() {}

  @override
  void didUpdateProvidedProperties({required FeedbackArgs newArgs}) {}

  @override
  void didUpdateBuildContext(BuildContext context) {}

  @override
  void dispose() {}
}

class $FeedbackPageDriverProvider extends WidgetDriverProvider<FeedbackPageDriver> {
  final FeedbackArgs _args;

  $FeedbackPageDriverProvider({
    required FeedbackArgs args,
  }) : _args = args;

  @override
  FeedbackPageDriver buildDriver() {
    return FeedbackPageDriver(
      args: _args,
    );
  }

  @override
  FeedbackPageDriver buildTestDriver() {
    return _$TestFeedbackPageDriver();
  }

  @override
  void updateDriverProvidedProperties(FeedbackPageDriver driver) {
    // In case you get a compiler error here, you have to implement _$DriverProvidedProperties in your driver.
    // Like this:
    //  class FeedbackPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
    //
    //    ...
    //
    //    @override
    //    void didUpdateProvidedProperties(...) {
    //      // Handle your updates
    //    }
    //  }
    driver.didUpdateProvidedProperties(
      newArgs: _args,
    );
  }
}

// ignore: one_member_abstracts
abstract class _$DriverProvidedProperties {
  /// This function allows you to react to changes of the `driverProvidableProperties` in the driver.
  ///
  /// These properties are coming to the driver from the widget, and in Flutter, the widgets get recreated often.
  /// But the driver does not get recreated for each widget creation. The drivers lifecycle is similar to that of a state.
  /// That means that your driver constructor is not called when a new widget is created.
  /// So the driver constructor does not get a chance to read any potential changes of the properties in the widget.
  ///
  /// Important, you do not need to call `notifyWidget()` in this method.
  /// This method is called right before the build method of the DrivableWidget.
  /// Thus all data changed here will be shown with the "currently ongoing render cycle".
  ///
  /// Very Important!!
  /// Because this function is running during the build process,
  /// it is NOT the place to run time consuming or blocking tasks etc. (like calling Api-Endpoints)
  /// This could greatly impact your apps performance.
  void didUpdateProvidedProperties({
    required FeedbackArgs newArgs,
  });
}
