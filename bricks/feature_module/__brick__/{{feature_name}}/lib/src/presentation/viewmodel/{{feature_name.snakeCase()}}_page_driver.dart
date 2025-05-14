import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../domain/model/{{feature_name.snakeCase()}}.dart';
import '../state/{{feature_name.snakeCase()}}_state.dart';

part '{{feature_name.snakeCase()}}_page_driver.g.dart';

@GenerateTestDriver()
class {{feature_name.pascalCase()}}PageDriver extends WidgetDriver {
  final _{{feature_name.snakeCase()}}State = GetIt.I.get<{{feature_name.pascalCase()}}State>();

  late AppLocalizations _appLocalizations;
  late LmuToast _toast;
  late {{feature_name.pascalCase()}}? _{{feature_name.snakeCase()}};
  late {{feature_name.pascalCase()}}LoadState _{{feature_name.snakeCase()}}LoadState;

  int _count = 0;

  bool get isLoading => _{{feature_name.snakeCase()}}LoadState != {{feature_name.pascalCase()}}LoadState.success;

  String get largeTitle => "{{feature_name.pascalCase()}}"; // create feature localizations

  String get {{feature_name.snakeCase()}}Id => _{{feature_name.snakeCase()}}?.id ?? '';

  String get title => _{{feature_name.snakeCase()}}?.name ?? '';
  
  String get description => _count.toString();

  void on{{feature_name.pascalCase()}}CardPressed() {
    _count += 1;
    notifyWidget();
  }

  void _on{{feature_name.pascalCase()}}LoadStateChanged() {
    _{{feature_name.snakeCase()}}LoadState = _{{feature_name.snakeCase()}}State.loadState.value;
    _{{feature_name.snakeCase()}} = _{{feature_name.snakeCase()}}State.{{feature_name.snakeCase()}};
    notifyWidget();

    if (_{{feature_name.snakeCase()}}LoadState ==  {{feature_name.pascalCase()}}LoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _{{feature_name.snakeCase()}}State.get{{feature_name.pascalCase()}}(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _{{feature_name.snakeCase()}}LoadState = _{{feature_name.snakeCase()}}State.loadState.value;
    _{{feature_name.snakeCase()}} = _{{feature_name.snakeCase()}}State.{{feature_name.snakeCase()}};
    _{{feature_name.snakeCase()}}State.loadState.addListener(_on{{feature_name.pascalCase()}}LoadStateChanged);
    _{{feature_name.snakeCase()}}State.get{{feature_name.pascalCase()}}();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _{{feature_name.snakeCase()}}State.loadState.removeListener(_on{{feature_name.pascalCase()}}LoadStateChanged);
    super.dispose();
  }
}
