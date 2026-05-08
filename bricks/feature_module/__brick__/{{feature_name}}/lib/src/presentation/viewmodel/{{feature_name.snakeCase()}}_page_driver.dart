import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';

part '{{feature_name.snakeCase()}}_page_driver.g.dart';

@GenerateTestDriver()
class {{feature_name.pascalCase()}}PageDriver extends WidgetDriver {
  final _usecase = GetIt.I.get<Get{{feature_name.pascalCase()}}Usecase>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  int _count = 0;

  bool get isLoading => _usecase.loadState != {{feature_name.pascalCase()}}LoadState.success;

  String get largeTitle => "{{feature_name.pascalCase()}}"; // TODO: Replace with localized title

  String get {{feature_name.snakeCase()}}Id => _usecase.data?.id ?? '';

  String get title => _usecase.data?.name ?? '';

  String get description => _count.toString();

  void on{{feature_name.pascalCase()}}CardPressed() {
    _count += 1;
    notifyWidget();
  }

  void _onStateChanged() {
    notifyWidget();

    if (_usecase.loadState == {{feature_name.pascalCase()}}LoadState.error) {
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
