import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lmu_app/lmu_app.dart';
import 'package:lmu_app/registry/module_registry.dart';

import 'registry/feature_modules.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final modulRegistry = ModuleRegistry(modules: modules);
  await modulRegistry.init();

  runApp(
    LmuApp(),
  );
}
