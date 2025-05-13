import 'package:core_routes/{{feature_name.snakeCase()}}.dart';
import 'package:flutter/widgets.dart';

import '../../../presentation/view/{{feature_name.snakeCase()}}_page.dart';

class {{feature_name.pascalCase()}}RouterImpl extends {{feature_name.pascalCase()}}Router {
  @override
  Widget buildMain(BuildContext context) => {{feature_name.pascalCase()}}Page();
}
