import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../themes.dart';

class LmuSlider extends StatefulWidget {
  const LmuSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.isDisabled = false,
    this.label,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final bool isDisabled;
  final String? label;

  @override
  State<LmuSlider> createState() => _LmuSliderState();
}

class _LmuSliderState extends State<LmuSlider> {
  double? _previousSnap;

  @override
  void initState() {
    super.initState();
    _previousSnap = widget.value;
  }

  void _handleChanged(double value) {
    if (widget.divisions != null) {
      final step = (widget.max - widget.min) / widget.divisions!;
      final snapped = (value / step).round() * step + widget.min;
      if (_previousSnap == null || (snapped - _previousSnap!).abs() > 0.001) {
        _previousSnap = snapped;
        LmuVibrations.secondary();
      }
    }
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final trackColor = colors.neutralColors.backgroundColors.mediumColors.base;
    final thumbColor = widget.isDisabled
        ? colors.neutralColors.backgroundColors.strongColors.base
        : colors.brandColors.backgroundColors.strongColors.base;

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: LmuSizes.size_6,
        activeTrackColor: trackColor,
        inactiveTrackColor: trackColor,
        disabledActiveTrackColor: trackColor,
        disabledInactiveTrackColor: trackColor,
        thumbColor: thumbColor,
        disabledThumbColor: thumbColor,
        activeTickMarkColor: trackColor,
        inactiveTickMarkColor: trackColor,
        disabledActiveTickMarkColor: trackColor,
        disabledInactiveTickMarkColor: trackColor,
        overlayShape: SliderComponentShape.noOverlay,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        trackShape: const RoundedRectSliderTrackShape(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Slider(
          value: widget.value.clamp(widget.min, widget.max),
          min: widget.min,
          max: widget.max,
          divisions: widget.divisions,
          label: widget.label,
          onChanged: widget.isDisabled ? null : _handleChanged,
        ),
      ),
    );
  }
}
