import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LmuSearchInputField extends StatefulWidget {
  const LmuSearchInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClearPressed,
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
  final VoidCallback? onClearPressed;
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
    minWidth: 48,
    maxWidth: 48,
    minHeight: 48,
    maxHeight: 48,
  );
  static const _focusedIconConstraints = BoxConstraints(
    minHeight: 16,
    maxHeight: 16,
    minWidth: 16,
    maxWidth: 16,
  );

  late final AnimationController _constraintsController;
  late Animation<double> _constraintsAnimation;

  InputStates _inputState = InputStates.base;

  bool get _showCancelButton => _inputState == InputStates.active || _inputState == InputStates.typing;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateInputState);
    widget.focusNode.addListener(_updateInputState);

    _constraintsController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _constraintsAnimation = _constraintsController.drive(
      CurveTween(
        curve: LmuAnimations.fastSmooth,
      ),
    );

    _constraintsController.value = 1.0;

    _updateInputState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateInputState);
    widget.focusNode.removeListener(_updateInputState);
    widget.focusNode.dispose();
    _constraintsController.dispose();
    super.dispose();
  }

  void _updateInputState() {
    if (!mounted) return;

    setState(() {
      final oldState = _inputState;
      if (widget.isLoading) {
        _inputState = InputStates.loading;
      } else if (widget.controller.text.isEmpty) {
        _inputState = widget.focusNode.hasFocus ? InputStates.active : InputStates.base;
      } else {
        _inputState = widget.focusNode.hasFocus ? InputStates.typing : InputStates.filled;
      }

      final wasBase = oldState == InputStates.base;
      final isBase = _inputState == InputStates.base;
      if (wasBase != isBase) {
        _constraintsController.forward(from: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.locals.app;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: _constraintsAnimation,
            builder: (context, child) => LmuInputField(
              hintText: localizations.search,
              controller: widget.controller,
              keyboardType: TextInputType.text,
              focusNode: widget.focusNode,
              inputState: _inputState,
              isAutocorrect: widget.isAutocorrect,
              leadingIcon: _buildLeadingIcon(
                inputState: _inputState,
                context: context,
              ),
              leadingIconConstraints: _buildLeadingIconConstraints(_inputState),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: LmuSizes.size_16,
              ),
              trailingIcon: _buildTrailingIcon(
                inputState: _inputState,
                context: context,
              ),
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
          ),
        ),
        _buildSuffix(
          inputState: _inputState,
          context: context,
        ),
      ],
    );
  }

  BoxConstraints? _buildLeadingIconConstraints(InputStates state) {
    final isBaseState = state == InputStates.base;
    final startConstraints = isBaseState ? _focusedIconConstraints : _baseIconConstraints;
    final endConstraints = isBaseState ? _baseIconConstraints : _focusedIconConstraints;

    return BoxConstraints.lerp(startConstraints, endConstraints, _constraintsAnimation.value);
  }

  Widget? _buildLeadingIcon({
    required InputStates inputState,
    required BuildContext context,
  }) {
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
      child: _getLeadingIconByState(inputState, context),
    );
  }

  static Widget? _getLeadingIconByState(
    InputStates inputState,
    BuildContext context,
  ) {
    switch (inputState) {
      case InputStates.base:
        return const Icon(LucideIcons.search);
      case InputStates.active:
        return null;
      case InputStates.typing:
        return null;
      case InputStates.filled:
        return null;
      case InputStates.loading:
        return null;
    }
  }

  Widget _buildTrailingIcon({
    required InputStates inputState,
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

  static Widget _getTrailingIconByState(
    InputStates inputState,
    BuildContext context,
  ) {
    switch (inputState) {
      case InputStates.base:
      case InputStates.active:
        return const SizedBox.shrink();
      case InputStates.typing:
        return Icon(
          key: const ValueKey('typing'),
          LucideIcons.x,
          color: context.colors.neutralColors.textColors.weakColors.base,
          size: LmuIconSizes.medium,
        );
      case InputStates.filled:
        return Icon(
          key: const ValueKey('filled'),
          LucideIcons.x,
          color: context.colors.neutralColors.textColors.strongColors.base,
          size: LmuIconSizes.medium,
        );
      case InputStates.loading:
        return const LmuProgressIndicator(
          color: ProgressIndicatorColor.weak,
          size: ProgressIndicatorSize.small,
        );
    }
  }

  Widget _buildSuffix({
    required InputStates inputState,
    required BuildContext context,
  }) {
    return AnimatedSwitcher(
      duration: _animationDuration,
      switchInCurve: LmuAnimations.fastSmooth,
      switchOutCurve: LmuAnimations.fastSmooth.flipped,
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            axisAlignment: 1.0,
            child: child,
          ),
        );
      },
      child: _getSuffixByState(inputState, context),
    );
  }

  Widget _getSuffixByState(
    InputStates inputState,
    BuildContext context,
  ) {
    if (_showCancelButton) {
      return Padding(
        key: const ValueKey('cancel_button'),
        padding: const EdgeInsets.only(left: LmuSizes.size_12),
        child: LmuButton(
          title: context.locals.app.cancel,
          emphasis: ButtonEmphasis.link,
          size: ButtonSize.large,
          increaseTouchTarget: true,
          onTap: _handleCancelTap,
        ),
      );
    }

    return const SizedBox.shrink(key: ValueKey('empty'));
  }

  void _handleCancelTap() {
    widget.controller.clear();
    widget.onClearPressed?.call();
    _updateInputState();
  }
}
