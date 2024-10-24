import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lmu_app/lmu_app.dart';
import 'package:lmu_app/module_registry.dart';

import 'feature_modules.dart';

GetIt getIt = GetIt.instance;

void main() async {
  final modulRegistry = ModuleRegistry(modules: modules);

  await modulRegistry.init();
  runApp(
    LmuApp(),
  );
}
