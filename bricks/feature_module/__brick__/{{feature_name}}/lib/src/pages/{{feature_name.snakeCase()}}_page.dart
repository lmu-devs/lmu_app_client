import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widgets/widgets.dart';
import '../cubit/{{feature_name.snakeCase()}}_cubit/cubit.dart';

class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  const {{feature_name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: "{{feature_name.pascalCase()}}", 
      body: BlocBuilder<{{feature_name.pascalCase()}}Cubit, {{feature_name.pascalCase()}}State>(
        bloc: GetIt.I.get<{{feature_name.pascalCase()}}Cubit>(),
        builder: (context, state) {
          if (state is {{feature_name.pascalCase()}}LoadSuccess) {
            return const {{feature_name.pascalCase()}}ContentView();
          }

          return const {{feature_name.pascalCase()}}LoadingView();
        },
      ),
    );
  }
}