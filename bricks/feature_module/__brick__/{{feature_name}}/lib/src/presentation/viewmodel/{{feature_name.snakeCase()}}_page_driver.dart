import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/{{feature_name.snakeCase()}}.dart';
import '../../application/state//{{feature_name.snakeCase()}}_state.dart';

part '{{feature_name.snakeCase()}}_page_driver.g.dart';

@GenerateTestDriver()
class {{feature_name.pascalCase()}}PageDriver extends WidgetDriver {
  final _{{feature_name.snakeCase()}}StateService = GetIt.I.get<{{feature_name.pascalCase()}}StateService>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late {{feature_name.pascalCase()}}? _{{feature_name.snakeCase()}};
  late {{feature_name.pascalCase()}}LoadState _{{feature_name.snakeCase()}}LoadState;

  int _count = 0;

  bool get isLoading => _{{feature_name.snakeCase()}}LoadState != {{feature_name.pascalCase()}}LoadState.success;

  String get largeTitle => "{{feature_name.pascalCase()}}"; // TODO: Replace with localized title

  String get {{feature_name.snakeCase()}}Id => _{{feature_name.snakeCase()}}?.id ?? '';

  String get title => _{{feature_name.snakeCase()}}?.name ?? '';

  String get description => _count.toString();

  void on{{feature_name.pascalCase()}}CardPressed() {
    _count += 1;
    notifyWidget();
  }

  void _on{{feature_name.pascalCase()}}StateChanged() {
    final state = _{{feature_name.snakeCase()}}StateService.stateNotifier.value;
    _{{feature_name.snakeCase()}}LoadState = state.loadState;
    _{{feature_name.snakeCase()}} = state.{{feature_name.snakeCase()}};
    notifyWidget();

    if (_{{feature_name.snakeCase()}}LoadState == {{feature_name.pascalCase()}}LoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _{{feature_name.snakeCase()}}StateService.get{{feature_name.pascalCase()}}(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    final state = _{{feature_name.snakeCase()}}StateService.stateNotifier.value;
    _{{feature_name.snakeCase()}}LoadState = state.loadState;
    _{{feature_name.snakeCase()}} = state.{{feature_name.snakeCase()}};
    _{{feature_name.snakeCase()}}StateService.stateNotifier.addListener(_on{{feature_name.pascalCase()}}StateChanged);
    _{{feature_name.snakeCase()}}StateService.get{{feature_name.pascalCase()}}();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _{{feature_name.snakeCase()}}StateService.stateNotifier.removeListener(_on{{feature_name.pascalCase()}}StateChanged);
    super.dispose();
  }
}
