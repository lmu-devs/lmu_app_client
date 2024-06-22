import 'package:core/components.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../views/wunschkonzert_success_view.dart';

class WunschkonzertMainPage extends StatelessWidget {
  const WunschkonzertMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColors.backgroundColors.base,
      appBar: const LmuDefaultNavigationBar(
        title: "Wunschkonzert",
      ),
      body: const WunschkonzertSuccessView(),
    );
  }
}
