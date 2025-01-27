import 'package:core/components.dart';
import 'package:flutter/widgets.dart';

class {{feature_name.pascalCase()}}LoadingView extends StatelessWidget {
  const {{feature_name.pascalCase()}}LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LmuText.body("Loading!"),
    );
  }
}