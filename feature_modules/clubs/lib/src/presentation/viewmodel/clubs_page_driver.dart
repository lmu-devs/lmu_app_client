import 'package:core/localizations.dart';
import 'package:core/utils.dart';
import 'package:core_routes/clubs.dart';
import 'package:get_it/get_it.dart';
import 'package:widget_driver/widget_driver.dart';

import '../../application/usecases/get_clubs_usecase.dart';
import '../../domain/models/club.dart';
import '../../domain/models/club_category.dart';

part 'clubs_page_driver.g.dart';

@GenerateTestDriver()
class ClubsPageDriver extends WidgetDriver {
  final _getClubsUsecase = GetIt.I.get<GetClubsUsecase>();

  late BuildContext _navigatorContext;
  late AppLocalizations _appLocalizations;
  late List<ClubCategory> _clubCategories;
  late LoadState _loadState;

  bool get isLoading => _loadState.isLoading;

  bool get isGenericError => _loadState.isGenericError;

  bool get isNoNetworkError => _loadState.isNoNetworkError;

  Club? get featuredClub => _clubCategories.expand((category) => category.clubs).where((c) => c.isFeatured).firstOrNull;

  String get allClubsTitle => _appLocalizations.showAll;
  String get allClubsCount => _clubCategories.expand((category) => category.clubs).length.toString();

  List<ClubCategory> get clubCategories => _clubCategories;

  void onAllClubsPressed() => const ClubsDetailsRoute().go(_navigatorContext);

  void onClubCategoryPressed(ClubCategory clubCategory) {
    ClubsDetailsRoute(categoryId: clubCategory.id).go(_navigatorContext);
  }

  void onFeaturedClubPressed(BuildContext context, Club club) {
    ClubDetailRoute(clubId: club.id).go(context);
  }

  void onRetry() => _getClubsUsecase.load();

  void _onGetClubsChanged() {
    _loadState = _getClubsUsecase.loadState;
    _clubCategories = _getClubsUsecase.clubCategories;
    notifyWidget();
  }

  @override
  void didInitDriver() {
    super.didInitDriver();
    _loadState = _getClubsUsecase.loadState;
    _clubCategories = _getClubsUsecase.clubCategories;
    _getClubsUsecase.addListener(_onGetClubsChanged);

    _getClubsUsecase.load();
  }

  @override
  void didUpdateBuildContext(BuildContext context) {
    super.didUpdateBuildContext(context);
    _appLocalizations = context.locals.app;
    _navigatorContext = context;
  }

  @override
  void dispose() {
    _getClubsUsecase.removeListener(_onGetClubsChanged);
    super.dispose();
  }
}
