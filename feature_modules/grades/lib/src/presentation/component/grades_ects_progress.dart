import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

class GradesEctsProgress extends StatefulWidget {
  const GradesEctsProgress({
    required this.archievedEcts,
    required this.maxEcts,
    super.key,
  });

  final double archievedEcts;
  final double maxEcts;

  @override
  State<GradesEctsProgress> createState() => _GradesEctsProgressState();
}

class _GradesEctsProgressState extends State<GradesEctsProgress> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late double _previousProgress;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _previousProgress = _calculateProgress();
    _progressAnimation = AlwaysStoppedAnimation(_previousProgress);
  }

  @override
  void didUpdateWidget(GradesEctsProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.archievedEcts != widget.archievedEcts || oldWidget.maxEcts != widget.maxEcts) {
      final newProgress = _calculateProgress();
      _progressAnimation = Tween<double>(
        begin: _previousProgress,
        end: newProgress,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      _previousProgress = newProgress;
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _calculateProgress() {
    final progress = widget.maxEcts > 0 ? widget.archievedEcts / widget.maxEcts : 0.0;
    return progress.clamp(0.0, 1.0);
  }

  String _formatEcts(double value) {
    return value == value.roundToDouble() ? value.toInt().toString() : value.toStringAsFixed(1).replaceAll(".", ",");
  }

  bool get _isOverMax => widget.archievedEcts > widget.maxEcts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Container(
                  width: constraints.maxWidth,
                  height: LmuSizes.size_8,
                  decoration: BoxDecoration(
                    color: context.colors.neutralColors.backgroundColors.mediumColors.base,
                    borderRadius: BorderRadius.circular(LmuSizes.size_4),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: _progressAnimation.value * constraints.maxWidth,
                      height: 8,
                      decoration: BoxDecoration(
                        color: context.colors.neutralColors.textColors.weakColors.base,
                        borderRadius: BorderRadius.circular(LmuSizes.size_4),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: LmuSizes.size_6),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              color: context.colors.neutralColors.textColors.mediumColors.base,
            ),
            children: [
              TextSpan(
                text: _formatEcts(widget.archievedEcts),
                style: TextStyle(
                  color: _isOverMax
                      ? context.colors.dangerColors.textColors.strongColors.base
                      : context.colors.neutralColors.textColors.mediumColors.base,
                  fontWeight: _isOverMax ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              TextSpan(text: " / ${_formatEcts(widget.maxEcts)} ECTS"),
            ],
          ),
        ),
      ],
    );
  }
}
