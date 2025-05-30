import 'package:core/localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/state/benefits_state_service.dart';
import '../../domain/models/benefit.dart';

part 'benefits_details_page_driver.g.dart';

@GenerateTestDriver()
class BenefitsDetailsPageDriver extends WidgetDriver {
  final _benefitsState = GetIt.I.get<BenefitsStateService>();

  late String _allTitle;
  late final List<Benefit> _benefitItems;
  late final String? _categoryTitle;

  List<Benefit>? get _selectedBenefits => _benefitsState.selectedCategory?.benefits;

  String get title => _categoryTitle ?? _allTitle;
  List<Benefit> get benefits => _benefitItems;

  @override
  void didInitDriver() {
    super.didInitDriver();
    _benefitItems = _selectedBenefits ??
        _benefitsState.state.value.benefitCategories.expand((category) => category.benefits).toSet().toList();
    _categoryTitle = _benefitsState.selectedCategory?.title;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _allTitle = "${context.locals.app.all} ${context.locals.benefits.benefitsTitle}";
  }

  @override
  void dispose() {
    super.dispose();
    _benefitsState.selectedCategory = null;
  }
}
