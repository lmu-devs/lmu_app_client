import 'package:core/components.dart';
import 'package:flutter/material.dart';

import '../views/wunschkonzert_success_view.dart';

class WunschkonzertMainPage extends StatelessWidget {
  const WunschkonzertMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuScaffoldWithAppBar(
      largeTitle: "Wunschkonzert",
      body: const WunschkonzertSuccessView(),
    );
  }
}
