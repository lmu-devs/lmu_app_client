import 'package:core/core_services.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_api/explore.dart';

import '../extensions/explore_marker_type_extension.dart';
import '../services/explore_location_service.dart';
import '../services/explore_map_service.dart';
import 'explore_map_dot.dart';
import 'explore_map_pin.dart';

class ExploreMarker extends StatefulWidget {
  const ExploreMarker({super.key, required this.exploreLocation});

  final ExploreLocation exploreLocation;

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

  final _mapService = GetIt.I<ExploreMapService>();
  final _locationService = GetIt.I<ExploreLocationService>();

  String get _id => widget.exploreLocation.id;
  ExploreMarkerType get _type => widget.exploreLocation.type;

  @override
  void initState() {
    super.initState();

    _selectedMarkerNotifier = _mapService.selectedMarkerNotifier;
    _markerSizeNotifier = _mapService.exploreMarkerSizeNotifier;

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
    return Stack(
      alignment: Alignment.center,
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
          alignment: Alignment.center,
          scale: _scaleAnimation,
          child: ExploreMapPin(pinColor: color, icon: _type.icon),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            final location = _locationService.getLocationById(_id);
            _locationService.bringToFront(_id);
            _mapService.updateMarker(location);
            GetIt.I<AnalyticsClient>().logClick(eventName: "map_marker_clicked", parameters: {"location": location.name});
          },
          child: SizedBox(
            width: _markerSizeNotifier.value.size,
            height: _markerSizeNotifier.value.size,
          ),
        ),
      ],
    );
  }
}

extension HitTestSize on ExploreMarkerSize {
  double get size {
    return switch (this) {
      ExploreMarkerSize.small => 20,
      ExploreMarkerSize.medium => 30,
      ExploreMarkerSize.large => 48,
    };
  }
}
