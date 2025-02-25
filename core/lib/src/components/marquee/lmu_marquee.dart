library marquee;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  Marquee({
    super.key,
    this.textList = const [],
    this.style,
    this.secondaryColor,
    this.textScaleFactor,
    this.textDirection = TextDirection.ltr,
    this.scrollAxis = Axis.horizontal,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.blankSpace = 0.0,
    this.velocity = 50.0,
    this.startAfter = Duration.zero,
    this.pauseAfterRound = Duration.zero,
    this.showFadingOnlyWhenScrolling = true,
    this.fadingEdgeStartFraction = 0.0,
    this.fadingEdgeEndFraction = 0.0,
    this.numberOfRounds,
    this.startPadding = 0.0,
    this.accelerationDuration = Duration.zero,
    Curve accelerationCurve = Curves.decelerate,
    this.decelerationDuration = Duration.zero,
    Curve decelerationCurve = Curves.decelerate,
    this.onDone,
  })  : assert(!blankSpace.isNaN),
        assert(blankSpace >= 0, "The blankSpace needs to be positive or zero."),
        assert(blankSpace.isFinite),
        assert(!velocity.isNaN),
        assert(velocity != 0.0, "The velocity cannot be zero."),
        assert(velocity.isFinite),
        assert(
          pauseAfterRound >= Duration.zero,
          "The pauseAfterRound cannot be negative as time travel isn't "
          "invented yet.",
        ),
        assert(
          fadingEdgeStartFraction >= 0 && fadingEdgeStartFraction <= 1,
          "The fadingEdgeGradientFractionOnStart value should be between 0 and "
          "1, inclusive",
        ),
        assert(
          fadingEdgeEndFraction >= 0 && fadingEdgeEndFraction <= 1,
          "The fadingEdgeGradientFractionOnEnd value should be between 0 and "
          "1, inclusive",
        ),
        assert(numberOfRounds == null || numberOfRounds > 0),
        assert(
          accelerationDuration >= Duration.zero,
          "The accelerationDuration cannot be negative as time travel isn't "
          "invented yet.",
        ),
        assert(
          decelerationDuration >= Duration.zero,
          "The decelerationDuration must be positive or zero as time travel "
          "isn't invented yet.",
        );

  final List<String> textList;

  final TextStyle? style;
  final Color? secondaryColor;

  final double? textScaleFactor;

  final TextDirection textDirection;

  final Axis scrollAxis;

  final CrossAxisAlignment crossAxisAlignment;

  final double blankSpace;

  final double velocity;

  final Duration startAfter;

  final Duration pauseAfterRound;

  final int? numberOfRounds;

  final bool showFadingOnlyWhenScrolling;

  final double fadingEdgeStartFraction;

  final double fadingEdgeEndFraction;

  final double startPadding;

  final Duration accelerationDuration;

  final Duration decelerationDuration;

  final VoidCallback? onDone;

  @override
  State<StatefulWidget> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();

  // The scroll positions at various scrolling phases.
  late double _startPosition; // At the start, before accelerating.
  late double _accelerationTarget; // After accelerating, before moving linearly.
  late double _linearTarget; // After moving linearly, before decelerating.

  // The durations of various scrolling phases.
  late Duration _totalDuration;

  Duration get _accelerationDuration => widget.accelerationDuration;
  Duration? _linearDuration; // The duration of linearly scrolling.
  Duration get _decelerationDuration => widget.decelerationDuration;

  bool _running = false;
  bool _isOnPause = false;
  int _roundCounter = 0;
  bool get isDone => widget.numberOfRounds == null ? false : widget.numberOfRounds == _roundCounter;
  bool get showFading => !widget.showFadingOnlyWhenScrolling ? true : !_isOnPause;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_running) {
        _running = true;
        if (_controller.hasClients) {
          _controller.jumpTo(_startPosition);
          await Future<void>.delayed(widget.startAfter);
          Future.doWhile(_scroll);
        }
      }
    });
  }

  Future<bool> _scroll() async {
    await _makeRoundTrip();
    if (isDone && widget.onDone != null) {
      widget.onDone!();
    }
    return _running && !isDone && _controller.hasClients;
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as Marquee);
  }

  @override
  void dispose() {
    _running = false;
    _controller.dispose();
    super.dispose();
  }

  void _initialize(BuildContext context) {
    // Calculate lengths (amount of pixels that each phase needs).
    final totalLength = _getTextWidth(context) + widget.blankSpace;
    const accelerationLength = 0.0;
    const decelerationLength = 0.0;
    final linearLength =
        (totalLength - accelerationLength.abs() - decelerationLength.abs()) * (widget.velocity > 0 ? 1 : -1);

    // Calculate scroll positions at various scrolling phases.
    _startPosition = 2 * totalLength - widget.startPadding;
    _accelerationTarget = _startPosition + accelerationLength;
    _linearTarget = _accelerationTarget + linearLength;

    // Calculate durations for the phases.
    _totalDuration = _accelerationDuration +
        _decelerationDuration +
        Duration(milliseconds: (linearLength / widget.velocity * 1000).toInt());
    _linearDuration = _totalDuration - _accelerationDuration - _decelerationDuration;

    assert(_totalDuration > Duration.zero);
    assert(_linearDuration! >= Duration.zero);
  }

  Future<void> _makeRoundTrip() async {
    // Reset the controller, then accelerate, move linearly and decelerate.
    if (!_controller.hasClients) return;
    _controller.jumpTo(_startPosition);
    if (!_running) return;

    await _moveLinearly();
    if (!_running) return;

    _roundCounter++;

    if (!_running || !mounted) return;

    if (widget.pauseAfterRound > Duration.zero) {
      setState(() => _isOnPause = true);

      await Future.delayed(widget.pauseAfterRound);

      if (!mounted || isDone) return;
      setState(() => _isOnPause = false);
    }
  }

  Future<void> _moveLinearly() async {
    await _animateTo(_linearTarget, _linearDuration);
  }

  Future<void> _animateTo(
    double? target,
    Duration? duration,
  ) async {
    if (!_controller.hasClients) return;
    if (duration! > Duration.zero) {
      await _controller.animateTo(target!, duration: duration, curve: Curves.linear);
    } else {
      _controller.jumpTo(target!);
    }
  }

  double _getTextWidth(BuildContext context) {
    const constraints = BoxConstraints(maxWidth: double.infinity);
    final spanList = widget.textList.mapIndexed((index, text) => TextSpan(text: text, style: widget.style)).toList();
    final richTextWidgetList = Text.rich(TextSpan(children: spanList)).build(context) as RichText;
    final renderObjectList = richTextWidgetList.createRenderObject(context);
    renderObjectList.layout(constraints);
    final boxesList = renderObjectList.getBoxesForSelection(TextSelection(
      baseOffset: 0,
      extentOffset: TextSpan(children: spanList).toPlainText().length,
    ));

    final totalLength = boxesList.reduce((value, element) => value.right > element.right ? value : element).right;

    return totalLength + (widget.blankSpace * (widget.textList.length - 1));
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    _initialize(context);
    final isHorizontal = widget.scrollAxis == Axis.horizontal;

    Alignment? alignment;

    switch (widget.crossAxisAlignment) {
      case CrossAxisAlignment.start:
        alignment = isHorizontal ? Alignment.topCenter : Alignment.centerLeft;
        break;
      case CrossAxisAlignment.end:
        alignment = isHorizontal ? Alignment.bottomCenter : Alignment.centerRight;
        break;
      case CrossAxisAlignment.center:
        alignment = Alignment.center;
        break;
      case CrossAxisAlignment.stretch:
      case CrossAxisAlignment.baseline:
        alignment = null;
        break;
    }

    return ListView.builder(
      controller: _controller,
      scrollDirection: widget.scrollAxis,
      reverse: widget.textDirection == TextDirection.rtl,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        final text = i.isEven
            ? Text(
                widget.textList[index++ % widget.textList.length],
                style: index % 2 == 0 ? widget.style : widget.style?.copyWith(color: widget.secondaryColor),
                textScaler: widget.textScaleFactor != null ? TextScaler.linear(widget.textScaleFactor!) : null,
              )
            : _buildBlankSpace();
        return alignment == null ? text : Align(alignment: alignment, child: text);
      },
    );
  }

  Widget _buildBlankSpace() {
    return SizedBox(
      width: widget.scrollAxis == Axis.horizontal ? widget.blankSpace : null,
      height: widget.scrollAxis == Axis.vertical ? widget.blankSpace : null,
    );
  }
}
