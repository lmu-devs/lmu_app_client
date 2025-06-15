import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecases/get_benefits_usecase.dart';
import '../../domain/models/benefit.dart';
import '../../domain/models/benefit_category.dart';

part 'benefits_details_page_driver.g.dart';

@GenerateTestDriver()
class BenefitsDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  BenefitsDetailsPageDriver({
    @driverProvidableProperty required BenefitCategory? selectedCategory,
  }) : _selectedCategory = selectedCategory;

  late final BenefitCategory? _selectedCategory;

  final _getBenefitsUsecase = GetIt.I.get<GetBenefitsUsecase>();

  late String _allTitle;
  late final List<Benefit> _benefitItems;
  late final String? _categoryTitle;

  List<Benefit>? get _selectedBenefits => _selectedCategory?.benefits;

  String get title => _categoryTitle ?? _allTitle;
  List<Benefit> get benefits => _benefitItems;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _benefitItems = _selectedBenefits ??
        _getBenefitsUsecase.benefitCategories.expand((category) => category.benefits).toSet().toList();
    _categoryTitle = _selectedCategory?.title;
  }

  @override
  void didUpdateProvidedProperties({
    required BenefitCategory? newSelectedCategory,
  }) {
    _selectedCategory = newSelectedCategory;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _allTitle = "${context.locals.app.all} ${context.locals.benefits.benefitsTitle}";
  }
}
