import 'package:core/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';
import 'lmu_app.dart';
import 'registry/feature_modules.dart';
import 'registry/module_registry.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppLogger().init();
  await Firebase.initializeApp(
    name: 'firebase-initalizer',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: '.env');

  final moduleRegistry = ModuleRegistry(modules: modules);
  await moduleRegistry.init();

  runApp(const LmuApp());
  FlutterNativeSplash.remove();
}
