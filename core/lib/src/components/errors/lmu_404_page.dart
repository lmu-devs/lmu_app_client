import 'package:core_routes/home.dart';
import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../logging.dart';

class Lmu404Page extends StatelessWidget {
  const Lmu404Page({super.key, this.exception});

  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.app;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(LmuSizes.size_16),
        child: SafeArea(
          child: LmuButton(
            title: localizations.errorButton404,
            showFullWidth: true,
            size: ButtonSize.large,
            onTap: () {
              AppLogger().logError("404 Page with $exception");
              const HomeMainRoute().go(context);
            }
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(LmuSizes.size_16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: LmuSizes.size_32),
              LmuText.h1(localizations.errorTitle404),
              const SizedBox(height: LmuSizes.size_12),
              LmuText.body(
                localizations.errorDescription404,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: LmuSizes.size_64),
              Expanded(
                child: Image.asset(
                  'lib/assets/404_error.webp',
                  package: 'core',
                  semanticLabel: '404 Error',
                  height: LmuSizes.size_96 * 2,
                  width: LmuSizes.size_96 * 2,
                ),
              ),
              const SizedBox(height: LmuSizes.size_64),
            ],
          ),
        ),
      ),
    );
  }
}
