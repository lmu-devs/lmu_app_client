import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/menu_cubit/menu_cubit.dart';
import '../repository/api/api.dart';
import '../views/details/mensa_details_content_view.dart';

class MensaDetailsPage extends StatelessWidget {
  const MensaDetailsPage({
    super.key,
    required this.mensaModel,
  });

  final MensaModel mensaModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MenuCubit>(
      create: (context) => MenuCubit(
        canteenId: mensaModel.canteenId,
      ),
      child: MensaDetailsContentView(
        mensaModel: mensaModel,
        currentDayOfWeek: 0,
      ),
    );
  }
}
