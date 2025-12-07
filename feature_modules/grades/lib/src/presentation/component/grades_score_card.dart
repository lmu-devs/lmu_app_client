import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';

import '../helpers/grades_formatting_extension.dart';
import '../helpers/grades_gradient_set.dart';

class GradesScoreCard extends StatefulWidget {
  const GradesScoreCard({
    required this.averageGrade,
    super.key,
  });

  final double averageGrade;

  @override
  State<GradesScoreCard> createState() => _GradesScoreCardState();
}

class _GradesScoreCardState extends State<GradesScoreCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradeAnimation;
  late double _previousGrade;

  @override
  void initState() {
    super.initState();
    _previousGrade = widget.averageGrade;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _gradeAnimation = Tween<double>(
      begin: widget.averageGrade,
      end: widget.averageGrade,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(GradesScoreCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.averageGrade != widget.averageGrade) {
      _previousGrade = oldWidget.averageGrade;
      _gradeAnimation = Tween<double>(
        begin: _previousGrade,
        end: widget.averageGrade,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final neutralColors = context.colors.neutralColors;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final gradientSet = context.gradeGradientSet;

    return AnimatedBuilder(
      animation: _gradeAnimation,
      builder: (context, child) {
        final animatedGrade = _gradeAnimation.value;
        final isEmpty = animatedGrade < 1.0;

        final bgStart = isEmpty
            ? neutralColors.backgroundColors.tile
            : gradientSet.backgrounds.interpValue(animatedGrade, min: 1.0, max: 5.0);
        final bgEnd = isEmpty
            ? neutralColors.backgroundColors.strongColors.base
            : gradientSet.texts.interpValue(animatedGrade, min: 1.0, max: 5.0);

        final textStart = isEmpty
            ? neutralColors.textColors.mediumColors.base
            : gradientSet.texts.interpValue(animatedGrade, min: 1.0, max: 5.0);
        final textEnd = isEmpty
            ? neutralColors.textColors.strongColors.base
            : gradientSet.highlights.interpValue(animatedGrade, min: 1.0, max: 5.0);

        return ClipRRect(
          borderRadius: BorderRadius.circular(LmuSizes.size_12),
          child: Container(
            width: double.infinity,
            color: context.colors.neutralColors.backgroundColors.tile,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topCenter,
                          colors: [
                            if (isLightMode) bgStart,
                            if (isLightMode) bgEnd,
                            if (!isLightMode) bgEnd,
                            if (!isLightMode) bgStart,
                          ],
                          radius: isLightMode ? 2.5 : 1.69,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    isEmpty ? 12 : LmuSizes.size_16,
                    LmuSizes.size_16,
                    LmuSizes.size_16,
                    LmuSizes.size_16,
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [textStart, textEnd],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          animatedGrade.asStringWithTwoDecimals,
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFeatures: [const FontFeature.tabularFigures()],
                            letterSpacing: isEmpty ? 0 : -2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
