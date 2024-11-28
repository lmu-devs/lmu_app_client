import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/localizations.dart';
import 'package:core/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LmuSearchInputField extends StatefulWidget {
  final TextEditingController controller;
  final BuildContext context;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool isDisabled;
  final VoidCallback? onClearPressed;

  const LmuSearchInputField({
    super.key,
    required this.controller,
    required this.context,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.isDisabled = false,
    this.onClearPressed,
  });

  @override
  State<LmuSearchInputField> createState() => _LmuSearchInputFieldState();
}

class _LmuSearchInputFieldState extends State<LmuSearchInputField> {
  late final FocusNode _focusNode;
  InputStates _inputState = InputStates.base;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    widget.controller.addListener(_updateInputState);
    _focusNode.addListener(_updateInputState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateInputState);
    _focusNode.removeListener(_updateInputState);
    _focusNode.dispose();
    super.dispose();
  }

  void _updateInputState() {
    setState(() {
      if (widget.controller.text.isEmpty) {
        _inputState =
            _focusNode.hasFocus ? InputStates.active : InputStates.base;
        print('Debug - Empty text -> State: $_inputState');
      } else {
        _inputState =
            _focusNode.hasFocus ? InputStates.typing : InputStates.filled;
        print('Debug - Has text -> State: $_inputState');
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
          child: LmuInputField(
            hintText: localizations.search,
            controller: widget.controller,
            keyboardType: TextInputType.text,
            isAutocorrect: false,
            focusNode: _focusNode,
            inputState: _inputState,
            leadingIcon: _buildLeadingIcon(
              inputState: _inputState,
              context: widget.context,
            ),
            leadingIconConstraints: _buildLeadingIconConstraints(_inputState),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: LmuSizes.mediumLarge,
            ),
            trailingIcon: _buildTrailingIcon(
              inputState: _inputState,
              onClearPressed: widget.onClearPressed,
              context: widget.context,
            ),
            onSubmitted: widget.onSubmitted,
            isDisabled: widget.isDisabled,
            onChanged: (value) {
              widget.onChanged?.call(value);
            },
          ),
        ),
        _buildSuffix(
          inputState: _inputState,
          context: widget.context,
        ),
      ],
    );
  }

  Widget _buildSuffix({
    required InputStates inputState,
    required BuildContext context,
  }) {
    const animationDuration = Duration(milliseconds: 300);
    final animationCurve = LmuAnimations.fastSmooth;
    
    return AnimatedSwitcher(
      duration: animationDuration,
      switchInCurve: animationCurve,
      switchOutCurve: animationCurve.flipped,
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
    final defaultButton = Padding(
      padding: const EdgeInsets.only(left: LmuSizes.medium),
      child: LmuButton(
        title: context.locals.app.cancel,
        emphasis: ButtonEmphasis.link,
        size: ButtonSize.large,
        onTap: () {},
      ),
    );
    switch (inputState) {
      case InputStates.base:
        return const SizedBox.shrink();
      case InputStates.active:
        return defaultButton;
      case InputStates.typing:
        return defaultButton;
      case InputStates.filled:
        return const SizedBox.shrink();
      case InputStates.loading:
        return const SizedBox.shrink();
    }
  }

  Widget? _buildLeadingIcon({
    required InputStates inputState,
    required BuildContext context,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
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

  BoxConstraints? _buildLeadingIconConstraints(InputStates state) {
    return _getLeadingIconConstraints(state);
  }

  Widget _buildTrailingIcon({
    required InputStates inputState,
    VoidCallback? onClearPressed,
    required BuildContext context,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: _getTrailingIconByState(inputState, onClearPressed, context),
    );
  }

  static BoxConstraints? _getLeadingIconConstraints(InputStates state) {
    const defaultConstraints = BoxConstraints(
      minWidth: 16,
      maxWidth: 16,
    );
    const wideConstraints = BoxConstraints(
      minWidth: 48,
      maxWidth: 48,
      minHeight: 48,
      maxHeight: 48,
    );
    switch (state) {
      case InputStates.base:
        return wideConstraints;
      case InputStates.active:
        return defaultConstraints;
      case InputStates.typing:
        return defaultConstraints;
      case InputStates.filled:
        return defaultConstraints;
      case InputStates.loading:
        return wideConstraints;
    }
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

  static Widget _getTrailingIconByState(
    InputStates inputState,
    VoidCallback? onClearPressed,
    BuildContext context,
  ) {
    switch (inputState) {
      case InputStates.base:
      case InputStates.active:
        return const SizedBox.shrink();
      case InputStates.typing:
        return GestureDetector(
          key: const ValueKey('typing'),
          onTap: onClearPressed,
          child: Icon(
            LucideIcons.x,
            color: context.colors.neutralColors.textColors.weakColors.base,
            size: LmuIconSizes.medium,
          ),
        );
      case InputStates.filled:
        return GestureDetector(
          key: const ValueKey('filled'),
          onTap: onClearPressed,
          child: Icon(
            LucideIcons.x,
            color: context.colors.neutralColors.textColors.strongColors.base,
            size: LmuIconSizes.medium,
          ),
        );
      case InputStates.loading:
        return const SizedBox(
          key: ValueKey('loading'),
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
    }
  }
}
