import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_lectures_usecase.dart';

part 'lectures_page_driver.g.dart';

@GenerateTestDriver()
class LecturesPageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetLecturesUsecase>();

  late AppLocalizations _appLocalizations;
  late LecturesLocatizations _lecturesLocatizations;
  late LmuToast _toast;

  int _count = 0;

  bool get isLoading => _usecase.loadState != LecturesLoadState.success;

  String get largeTitle => _lecturesLocatizations.lecturesTitle;

  String get lecturesId => _usecase.data?.id ?? '';

  String get title => _usecase.data?.name ?? '';

  String get description => _count.toString();

  void onLecturesCardPressed() {
    _count += 1;
    notifyWidget();
  }

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == LecturesLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _usecase.load(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _usecase.addListener(_onStateChanged);
    _usecase.load();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _lecturesLocatizations = context.locals.lectures;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
