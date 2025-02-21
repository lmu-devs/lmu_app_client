import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../services/explore_map_service.dart';
import 'explore_map_dot.dart';
import 'explore_map_pin.dart';

class ExploreMarker extends StatefulWidget {
  const ExploreMarker({super.key, required this.exploreLocation, required this.onActive});

  final ExploreLocation exploreLocation;
  final void Function(bool) onActive;

  @override
  State<ExploreMarker> createState() => _ExploreMarkerState();
}

class _ExploreMarkerState extends State<ExploreMarker> with TickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final AnimationController _fadeController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final ValueNotifier<String?> _selectedMarkerNotifier;
  late final ValueNotifier<ExploreMarkerSize> _markerSizeNotifier;

  final exploreMapService = GetIt.I<ExploreMapService>();

  String get _id => widget.exploreLocation.id;
  ExploreMarkerType get _type => widget.exploreLocation.type;
  void Function(bool) get _onActive => widget.onActive;

  @override
  void initState() {
    super.initState();

    _selectedMarkerNotifier = exploreMapService.selectedMarkerNotifier;
    _markerSizeNotifier = exploreMapService.exploreMarkerSizeNotifier;

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: LmuAnimations.gentle,
        reverseCurve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );

    _selectedMarkerNotifier.addListener(_onMarkerSelectionChanged);

    final isActive = _selectedMarkerNotifier.value == _id;
    if (isActive) {
      _scaleController.value = 1.0;
      _fadeController.value = 1.0;
    }
  }

  void _onMarkerSelectionChanged() {
    final isActive = _selectedMarkerNotifier.value == _id;
    if (isActive) {
      _fadeController.forward().then((_) => _scaleController.forward());
    } else {
      _scaleController.reverse().then((_) => _fadeController.reverse());
    }
  }

  @override
  void dispose() {
    _selectedMarkerNotifier.removeListener(_onMarkerSelectionChanged);
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _type.markerColor(context.colors);
    return GestureDetector(
      onTap: () {
        print(widget.exploreLocation.name);
        if (_selectedMarkerNotifier.value != _id) {
          _onActive(false);
        }
        exploreMapService.updateMarker(_id);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FadeTransition(
            opacity: _opacityAnimation,
            child: ValueListenableBuilder(
              valueListenable: _markerSizeNotifier,
              builder: (_, markerSize, __) {
                return ExploreMapDot(
                  dotColor: color,
                  icon: _type.icon,
                  markerSize: markerSize,
                );
              },
            ),
          ),
          ScaleTransition(
            alignment: Alignment.bottomCenter,
            scale: _scaleAnimation,
            child: ExploreMapPin(pinColor: color, icon: _type.icon),
          ),
        ],
      ),
    );
  }
}

extension on ExploreMarkerType {
  Color markerColor(LmuColors colors) {
    return switch (this) {
      ExploreMarkerType.mensaMensa => colors.mensaColors.textColors.mensa,
      ExploreMarkerType.mensaStuBistro => colors.mensaColors.textColors.stuBistro,
      ExploreMarkerType.mensaStuCafe => colors.mensaColors.textColors.stuCafe,
      ExploreMarkerType.mensaStuLounge => colors.mensaColors.textColors.stuLounge,
      ExploreMarkerType.cinema => const Color(0xFFD64444),
      ExploreMarkerType.roomfinderRoom => const Color(0xFF1A95F3),
    };
  }

  IconData get icon {
    return switch (this) {
      ExploreMarkerType.mensaMensa => LucideIcons.utensils,
      ExploreMarkerType.mensaStuBistro => LucideIcons.utensils,
      ExploreMarkerType.mensaStuCafe => LucideIcons.utensils,
      ExploreMarkerType.mensaStuLounge => LucideIcons.coffee,
      ExploreMarkerType.cinema => LucideIcons.clapperboard,
      ExploreMarkerType.roomfinderRoom => LucideIcons.school,
    };
  }
}
