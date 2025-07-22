import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/developerdex.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../themes.dart';

enum EmptyStateType { generic, noInternet, noSearchResults, closed, custom }

class LmuEmptyState extends StatefulWidget {
  const LmuEmptyState({
    super.key,
    this.type = EmptyStateType.generic,
    this.onRetry,
    this.assetName,
    this.title,
    this.description,
  });

  final EmptyStateType type;
  final String? assetName;
  final String? title;
  final String? description;
  final void Function()? onRetry;

  @override
  State<LmuEmptyState> createState() => _LmuEmptyStateState();
}

class _LmuEmptyStateState extends State<LmuEmptyState> {
  late final DeveloperdexApi _developerdexApi;
  late Widget? encounterWidget;

  @override
  void initState() {
    super.initState();
    _developerdexApi = GetIt.I.get<DeveloperdexApi>();
    encounterWidget = _developerdexApi.getDeveloperEncounter();
  }

  @override
  Widget build(BuildContext context) {
    final locals = context.locals;
    final asset = widget.assetName ?? _assetName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_24),
      child: Column(
        children: [
          encounterWidget ??
              Image.asset(
                asset,
                height: 128,
                fit: BoxFit.cover,
                package: "core",
              ),
          const SizedBox(height: LmuSizes.size_12),
          LmuText.h3(widget.title ?? _getTitle(locals), textAlign: TextAlign.center),
          const SizedBox(height: LmuSizes.size_6),
          LmuText.body(
            widget.description ?? _getDescription(locals),
            color: context.colors.neutralColors.textColors.mediumColors.base,
            textAlign: TextAlign.center,
          ),
          if (widget.onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: LmuSizes.size_24),
              child: LmuButton(
                title: locals.app.tryAgain,
                emphasis: ButtonEmphasis.primary,
                onTap: widget.onRetry,
              ),
            )
        ],
      ),
    );
  }

  String get _assetName {
    return switch (widget.type) {
      EmptyStateType.generic => "lib/assets/generic_error.png",
      EmptyStateType.noInternet => "lib/assets/internet_error.png",
      EmptyStateType.noSearchResults => "lib/assets/empty_search.png",
      EmptyStateType.closed => "lib/assets/closed.png",
      EmptyStateType.custom => throw ("Please provide a custom asset name for custom state"),
    };
  }

  String _getTitle(LmuLocalizations locals) {
    final appLocals = locals.app;
    return switch (widget.type) {
      EmptyStateType.generic => appLocals.somethingWentWrong,
      EmptyStateType.noInternet => appLocals.noInternetConnection,
      EmptyStateType.noSearchResults => appLocals.noSearchResults,
      EmptyStateType.closed => appLocals.allClosed,
      EmptyStateType.custom => throw ("Please provide a custom title for custom state"),
    };
  }

  String _getDescription(LmuLocalizations locals) {
    final appLocals = locals.app;
    return switch (widget.type) {
      EmptyStateType.generic => appLocals.somethingWentWrongDescription,
      EmptyStateType.noInternet => appLocals.noInternetConnectionDescription,
      EmptyStateType.noSearchResults => appLocals.noSearchResultsDescription,
      EmptyStateType.closed => throw ("Please provide a custom description for allClosed state"),
      EmptyStateType.custom => throw ("Please provide a custom description for custom state"),
    };
  }
}
