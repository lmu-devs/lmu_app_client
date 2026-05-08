import 'package:core/localizations.dart';
import 'package:widget_driver/widget_driver.dart';

part 'content_details_page_driver.g.dart';

@GenerateTestDriver()
class ContentDetailsPageDriver extends WidgetDriver
    implements _$DriverProvidedProperties {
  ContentDetailsPageDriver({
    @driverProvidableProperty required this.content,
  });

  final String content;

  late LmuLocalizations _localizations;
  String get pageTitle => _localizations.courses.content;

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _localizations = context.locals;
  }

  @override
  void didUpdateProvidedProperties({required String newContent}) {}
}
