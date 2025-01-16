import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_api/feedback.dart';

import '../routes/cinema_routes.dart';

class CinemaMainPage extends StatelessWidget {
  const CinemaMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: LmuContentTile(
            content: [LmuListItem.base(title: 'Cinema', subtitle: 'test')]),
      ),
    );
  }
}
