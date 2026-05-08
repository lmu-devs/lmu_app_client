import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import '../../../components.dart';
import '../../../constants.dart';
import '../../../localizations.dart';
import '../../../themes.dart';

class LmuSearchInputField extends StatefulWidget {
  const LmuSearchInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClearPressed,
    this.onCancelPressed,
    this.onTap,
    this.onOutsideTap,
    this.focusAfterClear = true,
    this.isAutofocus = false,
    this.isAutocorrect = true,
    this.isLoading = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final bool focusAfterClear;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function(InputState)? onTap;
  final VoidCallback? onClearPressed;
  final VoidCallback? onCancelPressed;
  final VoidCallback? onOutsideTap;
  final bool isAutofocus;
  final bool isAutocorrect;
  final bool isLoading;

  @override
  State<LmuSearchInputField> createState() => _LmuSearchInputFieldState();
}

class _LmuSearchInputFieldState extends State<LmuSearchInputField> with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 300);
  final Curve _animationCurve = LmuAnimations.fastSmooth;
  static const _baseIconConstraints = BoxConstraints(
    minWidth: 44,
    maxWidth: 44,
    minHeight: 44,
    maxHeight: 44,
  );
  static const _focusedIconConstraints = BoxConstraints(
    minHeight: 16,
    maxHeight: 16,
    minWidth: 16,
    maxWidth: 16,
  );

  late final AnimationController _constraintsController;
  late Animation<double> _constraintsAnimation;

  InputState _inputState = InputState.base;

  //bool get _showCancelButton => _inputState == InputState.active || _inputState == InputState.typing;

  TextEditingController get _controller => widget.controller;

  FocusNode get _focusNode => widget.focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_updateInputState);

    _constraintsController = AnimationController(duration: _animationDuration, vsync: this);
    _constraintsAnimation = _constraintsController.drive(CurveTween(curve: LmuAnimations.fastSmooth));
    _constraintsController.value = 1.0;

    _updateInputState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_updateInputState);
    _constraintsController.dispose();
    super.dispose();
  }

  void _updateInputState() {
    final oldState = _inputState;

    setState(() {
      if (widget.isLoading) {
        _inputState = InputState.loading;
      } else if (_controller.text.isEmpty) {
        _inputState = _focusNode.hasFocus ? InputState.active : InputState.base;
      } else {
        _inputState = _focusNode.hasFocus ? InputState.typing : InputState.filled;
      }
    });

    final wasBase = oldState == InputState.base;
    final isBase = _inputState == InputState.base;
    if (wasBase != isBase) {
      _constraintsController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.app;
    return AnimatedBuilder(
      animation: _constraintsAnimation,
      builder: (context, child) => LmuInputField(
        hintText: localizations.search,
        controller: _controller,
        keyboardType: TextInputType.text,
        focusNode: _focusNode,
        inputState: _inputState,
        isAutocorrect: widget.isAutocorrect,
        leadingIcon: _buildLeadingIcon(inputState: _inputState),
        leadingIconConstraints: _buildLeadingIconConstraints(_inputState),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: LmuSizes.size_16,
        ),
        trailingIcon: _buildTrailingIcon(
          inputState: _inputState,
          context: context,
        ),
        onTap: () => widget.onTap?.call(_inputState),
        onTapOutside: widget.onOutsideTap,
        onSubmitted: widget.onSubmitted,
        onChanged: (value) {
          _updateInputState();
          widget.onChanged?.call(value);
        },
        onClearPressed: () {
          widget.onClearPressed?.call();
          _updateInputState();
        },
        focusAfterClear: widget.focusAfterClear,
        isAutofocus: widget.isAutofocus,
      ),
    );
  }

  BoxConstraints? _buildLeadingIconConstraints(InputState state) {
    final isBaseState = state == InputState.base;
    final startConstraints = isBaseState ? _focusedIconConstraints : _baseIconConstraints;
    final endConstraints = isBaseState ? _baseIconConstraints : _focusedIconConstraints;

    return BoxConstraints.lerp(startConstraints, endConstraints, _constraintsAnimation.value);
  }

  Widget? _buildLeadingIcon({required InputState inputState}) {
    return AnimatedSwitcher(
      duration: _animationDuration,
      switchInCurve: _animationCurve,
      switchOutCurve: _animationCurve.flipped,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: inputState == InputState.base
          ? const LmuIcon(
              icon: LucideIcons.search,
              size: LmuIconSizes.mediumSmall,
            )
          : null,
    );
  }

  Widget _buildTrailingIcon({
    required InputState inputState,
    required BuildContext context,
  }) {
    return AnimatedSwitcher(
      duration: _animationDuration,
      switchInCurve: _animationCurve,
      switchOutCurve: _animationCurve.flipped,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: _getTrailingIconByState(inputState, context),
    );
  }

  Widget _getTrailingIconByState(InputState inputState, BuildContext context) {
    switch (inputState) {
      case InputState.base:
      case InputState.active:
        return const SizedBox.shrink();
      case InputState.filled:
      case InputState.typing:
        return LmuIcon(
          key: const ValueKey('typing'),
          icon: LucideIcons.x,
          color: context.colors.neutralColors.textColors.weakColors.base,
          size: LmuIconSizes.mediumSmall,
        );

      case InputState.loading:
        return const LmuProgressIndicator(
          color: ProgressIndicatorColor.weak,
          size: ProgressIndicatorSize.small,
        );
    }
  }

  // Widget _buildSuffix({
  //   required InputState inputState,
  //   required BuildContext context,
  // }) {
  //   return AnimatedSwitcher(
  //     duration: _animationDuration,
  //     switchInCurve: LmuAnimations.fastSmooth,
  //     switchOutCurve: LmuAnimations.fastSmooth.flipped,
  //     layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
  //       return Stack(
  //         alignment: Alignment.centerRight,
  //         children: <Widget>[
  //           ...previousChildren,
  //           if (currentChild != null) currentChild,
  //         ],
  //       );
  //     },
  //     transitionBuilder: (Widget child, Animation<double> animation) {
  //       return FadeTransition(
  //         opacity: animation,
  //         child: SizeTransition(
  //           sizeFactor: animation,
  //           axis: Axis.horizontal,
  //           axisAlignment: 1.0,
  //           child: child,
  //         ),
  //       );
  //     },
  //     child: _getSuffixByState(inputState, context),
  //   );
  // }

  // Widget _getSuffixByState(
  //   InputState inputState,
  //   BuildContext context,
  // ) {
  //   if (_showCancelButton) {
  //     return Padding(
  //       key: const ValueKey('cancel_button'),
  //       padding: const EdgeInsets.only(left: LmuSizes.size_12),
  //       child: LmuButton(
  //         title: context.locals.app.cancel,
  //         emphasis: ButtonEmphasis.link,
  //         size: ButtonSize.large,
  //         increaseTouchTarget: true,
  //         onTap: _handleCancelTap,
  //       ),
  //     );
  //   }

  //   return const SizedBox.shrink(key: ValueKey('empty'));
  // }

  // void _handleCancelTap() {
  //   _controller.clear();
  //   _updateInputState();
  //   widget.onCancelPressed?.call();
  // }
}
