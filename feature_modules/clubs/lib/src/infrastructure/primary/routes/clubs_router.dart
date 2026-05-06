import 'package:core_routes/clubs.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../../application/usecases/get_clubs_usecase.dart';
import '../../../presentation/view/club_detail_page.dart';
import '../../../presentation/view/clubs_details_page.dart';
import '../../../presentation/view/clubs_page.dart';

class ClubsRouterImpl extends ClubsRouter {
  @override
  Widget buildMain(BuildContext context) => ClubsPage();

  @override
  Widget buildDetails(BuildContext context, {required String? categoryId}) {
    final usecase = GetIt.I.get<GetClubsUsecase>();
    final category =
        categoryId != null ? usecase.clubCategories.where((c) => c.type.name == categoryId).firstOrNull : null;
    return ClubsDetailsPage(category: category);
  }

  @override
  Widget buildDetail(BuildContext context, {required String clubId}) {
    final usecase = GetIt.I.get<GetClubsUsecase>();
    final club = usecase.clubCategories.expand((c) => c.clubs).where((c) => c.id == clubId).first;
    return ClubDetailPage(club: club);
  }
}
