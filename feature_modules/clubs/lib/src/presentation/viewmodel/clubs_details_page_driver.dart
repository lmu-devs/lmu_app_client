import 'package:core/localizations.dart';
import 'package:core_routes/clubs.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecases/get_clubs_usecase.dart';
import '../../domain/models/club.dart';
import '../../domain/models/club_category.dart';
import '../../domain/models/club_category_type.dart';

part 'clubs_details_page_driver.g.dart';

@GenerateTestDriver()
class ClubsDetailsPageDriver extends WidgetDriver implements _$DriverProvidedProperties {
  ClubsDetailsPageDriver({
    @driverProvidableProperty required ClubCategory? selectedCategory,
  }) : _selectedCategory = selectedCategory;

  late ClubCategory? _selectedCategory;

  final _getClubsUsecase = GetIt.I.get<GetClubsUsecase>();

  late String _allTitle;
  late final List<Club> _clubItems;
  late final String? _categoryTitle;

  List<Club>? get _selectedClubs => _selectedCategory?.clubs;

  String get title => _categoryTitle ?? _allTitle;
  List<Club> get clubs => _clubItems;

  void onClubPressed(BuildContext context, Club club) {
    ClubDetailsDetailRoute(clubId: club.id).go(context);
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _clubItems = _selectedClubs ?? _getClubsUsecase.clubCategories.expand((category) => category.clubs).toList();
    _categoryTitle = _selectedCategory?.type.displayName;
  }

  @override
  void didUpdateProvidedProperties({
    required ClubCategory? newSelectedCategory,
  }) {
    _selectedCategory = newSelectedCategory;
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _allTitle = "${context.locals.app.all} ${context.locals.clubs.clubsTitle}";
  }
}
