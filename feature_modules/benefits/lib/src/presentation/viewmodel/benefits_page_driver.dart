import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:core_routes/benefits.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecases/get_benefits_usecase.dart';
import '../../domain/models/benefit_category.dart';

part 'benefits_page_driver.g.dart';

@GenerateTestDriver()
class BenefitsPageDriver extends WidgetDriver {
  final _getBenefitsUsecase = GetIt.I.get<GetBenefitsUsecase>();

  late BuildContext _navigatorContext;
  late AppLocalizations _appLocalizations;
  late List<BenefitCategory> _benefitsCategories;
  late LoadState _loadState;

  bool get isLoading => _loadState.isLoading;

  bool get isGenericError => _loadState.isGenericError;

  bool get isNoNetworkError => _loadState.isNoNetworkError;

  String get allBenefitsTitle => _appLocalizations.showAll;
  String get allBenefitsCount =>
      _benefitsCategories.expand((benefitCategory) => benefitCategory.benefits).toSet().length.toString();

  List<BenefitCategory> get benefitsCategories => _benefitsCategories;

  void onAllBenefitsPressed() => const BenefitsDetailsRoute(null).go(_navigatorContext);

  void onBenefitCategoryPressed(BenefitCategory benefitCategory) {
    BenefitsDetailsRoute(benefitCategory).go(_navigatorContext);
  }

  void onRetry() => _getBenefitsUsecase.load();

  void _onGetBenefitsChanged() {
    _loadState = _getBenefitsUsecase.loadState;
    _benefitsCategories = _getBenefitsUsecase.benefitCategories;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _loadState = _getBenefitsUsecase.loadState;
    _benefitsCategories = _getBenefitsUsecase.benefitCategories;
    _getBenefitsUsecase.addListener(_onGetBenefitsChanged);

    _getBenefitsUsecase.load();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _navigatorContext = context;
  }

  @override
  void dispose() {
    _getBenefitsUsecase.removeListener(_onGetBenefitsChanged);
    super.dispose();
  }
}
