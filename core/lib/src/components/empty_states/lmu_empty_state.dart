import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/settings.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../themes.dart';

enum EmptyStateType { generic, noInternet, noSearchResults, allClosed, custom }

class LmuEmptyState extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final safariApi = GetIt.I.get<SafariApi>();

    final locals = context.locals;
    final asset = assetName ?? _assetName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: LmuSizes.size_24),
      child: Column(
        children: [
          _AnimatedTapImage(
            key: Key("empty_state_${type.name}"),
            assetName: asset,
            height: 128,
            fit: BoxFit.cover,
            package: "core",
            onTap: () => safariApi.animalSeen(asset.toSafariAnimal()),
          ),
          const SizedBox(height: LmuSizes.size_12),
          LmuText.h3(title ?? _getTitle(locals), textAlign: TextAlign.center),
          const SizedBox(height: LmuSizes.size_6),
          LmuText.body(
            description ?? _getDescription(locals),
            color: context.colors.neutralColors.textColors.mediumColors.base,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: LmuSizes.size_24),
              child: LmuButton(
                title: locals.app.tryAgain,
                emphasis: ButtonEmphasis.primary,
                onTap: onRetry,
              ),
            )
        ],
      ),
    );
  }

  String get _assetName {
    return switch (type) {
      EmptyStateType.generic => LmuAnimalAssets.blobfish,
      EmptyStateType.noInternet => LmuAnimalAssets.capybara,
      EmptyStateType.noSearchResults => LmuAnimalAssets.mole,
      EmptyStateType.allClosed => LmuAnimalAssets.sloth,
      EmptyStateType.custom => throw ("Please provide a custom asset name for custom state"),
    };
  }

  String _getTitle(LmuLocalizations locals) {
    final appLocals = locals.app;
    return switch (type) {
      EmptyStateType.generic => appLocals.somethingWentWrong,
      EmptyStateType.noInternet => appLocals.noInternetConnection,
      EmptyStateType.noSearchResults => appLocals.noSearchResults,
      EmptyStateType.allClosed => appLocals.allClosed,
      EmptyStateType.custom => throw ("Please provide a custom title for custom state"),
    };
  }

  String _getDescription(LmuLocalizations locals) {
    final appLocals = locals.app;
    return switch (type) {
      EmptyStateType.generic => appLocals.somethingWentWrongDescription,
      EmptyStateType.noInternet => appLocals.noInternetConnectionDescription,
      EmptyStateType.noSearchResults => appLocals.noSearchResultsDescription,
      EmptyStateType.allClosed => throw ("Please provide a custom description for allClosed state"),
      EmptyStateType.custom => throw ("Please provide a custom description for custom state"),
    };
  }
}

class _AnimatedTapImage extends StatefulWidget {
  const _AnimatedTapImage({
    super.key,
    required this.assetName,
    this.height,
    this.fit,
    this.package,
    this.onTap,
  });

  final String assetName;
  final double? height;
  final BoxFit? fit;
  final String? package;
  final void Function()? onTap;

  @override
  State<_AnimatedTapImage> createState() => _AnimatedTapImageState();
}

class _AnimatedTapImageState extends State<_AnimatedTapImage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  final Random _random = Random();
  double _rotationAngle = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller);
  }

  void _onTap() {
    setState(() {
      _rotationAngle = (_random.nextDouble() - 0.5) * 0.2;
      _rotationAnimation = Tween<double>(
        begin: 0.0,
        end: _rotationAngle,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
    });

    widget.onTap?.call();

    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: Image.asset(
          widget.assetName,
          height: widget.height,
          fit: widget.fit,
          package: widget.package,
        ),
      ),
    );
  }
}
