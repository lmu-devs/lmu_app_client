import 'package:flutter/material.dart';
import 'package:mensa/src/repository/api/models/mensa_menu_week_model.dart';

class MensaMenuContentView extends StatelessWidget {
  const MensaMenuContentView({
    Key? key,
    required this.mensaMenuModel,
  }) : super(key: key);

  final MensaMenuWeekModel mensaMenuModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        mensaMenuModel.toString(),
      ),
    );
  }
}
