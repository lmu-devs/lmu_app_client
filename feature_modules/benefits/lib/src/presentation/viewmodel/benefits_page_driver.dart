import 'package:core/components.dart';
import 'package:core/localizations.dart';
import 'package:core_routes/benefits.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/benefits_state_service.dart';
import '../../domain/models/benefit_category.dart';

part 'benefits_page_driver.g.dart';

@GenerateTestDriver()
class BenefitsPageDriver extends WidgetDriver {
  final _benefitsState = GetIt.I.get<BenefitsStateService>();

  late BuildContext _navigatorContext;
  late AppLocalizations _appLocalizations;
  late LmuToast _toast;

  late List<BenefitCategory> _benefitsCategories;
  late BenefitsLoadState _benefitsLoadState;

  bool get isLoading =>
      _benefitsLoadState != BenefitsLoadState.success && _benefitsLoadState != BenefitsLoadState.loadingWithCache;

  String get allBenefitsTitle => _appLocalizations.showAll;
  String get allBenefitsCount =>
      _benefitsCategories.expand((benefitCategory) => benefitCategory.benefits).toSet().length.toString();

  List<BenefitCategory> get benefitsCategories => _benefitsCategories;

  void onAllBenefitsPressed() {
    _benefitsState.selectedCategory = null;
    const BenefitsDetailsRoute().go(_navigatorContext);
  }

  void onBenefitCategoryPressed(BenefitCategory benefitCategory) {
    _benefitsState.selectedCategory = benefitCategory;
    const BenefitsDetailsRoute().go(_navigatorContext);
  }

  void _onBenefitsLoadStateChanged() {
    final newState = _benefitsState.state.value;
    _benefitsLoadState = newState.loadState;
    _benefitsCategories = _benefitsState.state.value.benefitCategories;

    notifyWidget();

    if (_benefitsLoadState == BenefitsLoadState.error) {
      _showErrorToast();
    }
  }

  void _showErrorToast() {
    _toast.showToast(
      message: _appLocalizations.somethingWentWrong,
      type: ToastType.error,
      actionText: _appLocalizations.tryAgain,
      onActionPressed: () => _benefitsState.getBenefits(),
    );
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    final initialState = _benefitsState.state.value;
    _benefitsLoadState = initialState.loadState;
    _benefitsCategories = initialState.benefitCategories;
    _benefitsState.state.addListener(_onBenefitsLoadStateChanged);

    _benefitsState.getBenefits();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _navigatorContext = context;
    _toast = LmuToast.of(context);
  }

  @override
  void dispose() {
    _benefitsState.state.removeListener(_onBenefitsLoadStateChanged);

    super.dispose();
  }
}
