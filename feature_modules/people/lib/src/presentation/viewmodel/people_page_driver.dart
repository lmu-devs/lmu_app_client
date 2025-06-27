import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_people_usecase.dart';

part 'people_page_driver.g.dart';

@GenerateTestDriver()
class PeoplePageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<GetPeopleUsecase>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  int _count = 0;

  bool get isLoading => _usecase.loadState != PeopleLoadState.success;

  String get largeTitle => "People"; // TODO: Replace with localized title

  String get peopleId => _usecase.data?.id ?? '';

  String get title => _usecase.data?.name ?? '';

  String get description => _count.toString();

  void onPeopleCardPressed() {
    _count += 1;
    notifyWidget();
  }

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == PeopleLoadState.error) {
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
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _usecase.removeListener(_onStateChanged);
    super.dispose();
  }
}
