import 'package:core/components.dart';
import 'package:flutter/widgets.dart';

class TimelineLoadingView extends StatelessWidget {
  const TimelineLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuText.body("Loading!"),
    );
  }
}
