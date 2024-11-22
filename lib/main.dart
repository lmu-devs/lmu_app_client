import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'lmu_app.dart';
import 'registry/module_registry.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'registry/feature_modules.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: '.env');

  final moduleRegistry = ModuleRegistry(modules: modules);
  await moduleRegistry.init();

  runApp(
    LmuApp(),
  );
  FlutterNativeSplash.remove();
}
