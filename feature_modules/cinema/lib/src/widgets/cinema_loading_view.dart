import 'package:core/components.dart';
import 'package:flutter/widgets.dart';

class CinemaLoadingView extends StatelessWidget {
  const CinemaLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuText.body("Loading!"),
    );
  }
}