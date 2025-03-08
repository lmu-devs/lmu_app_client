import 'package:core/components.dart';
import 'package:flutter/widgets.dart';

class RoomfinderLoadingView extends StatelessWidget {
  const RoomfinderLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuText.body("Loading!"),
    );
  }
}
