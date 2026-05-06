import 'package:flutter/widgets.dart';

abstract class ClubsRouter {
  Widget buildMain(BuildContext context);

  Widget buildDetails(BuildContext context, {required String? categoryId});

  Widget buildDetail(BuildContext context, {required String clubId});
}
