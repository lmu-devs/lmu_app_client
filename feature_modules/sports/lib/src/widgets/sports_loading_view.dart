import 'package:core/components.dart';
import 'package:flutter/widgets.dart';

class SportsLoadingView extends StatelessWidget {
  const SportsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuText.body("Loading!"),
    );
  }
}
