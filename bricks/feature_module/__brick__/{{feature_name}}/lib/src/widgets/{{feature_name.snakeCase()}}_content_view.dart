import 'package:core/components.dart';
import 'package:flutter/widgets.dart';

class {{feature_name.pascalCase()}}ContentView extends StatelessWidget {
  const {{feature_name.pascalCase()}}ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuText.body("Success!"),
    );
  }
}