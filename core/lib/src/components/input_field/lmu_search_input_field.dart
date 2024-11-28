import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:core/themes.dart';
import 'lmu_input_field.dart';

enum SearchState {
  base,
  active,
  typing,
  filled,
  loading,
}

class LmuSearchInputField extends LmuInputField {
  final SearchState searchState;
  final VoidCallback? onClearPressed;

  LmuSearchInputField({
    super.key,
    required TextEditingController controller,
    required BuildContext context,
    String hintText = 'Search',
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
    bool isDisabled = false,
    this.searchState = SearchState.base,
    this.onClearPressed,
  }) : super(
          hintText: hintText,
          controller: controller,
          keyboardType: TextInputType.text,
          isAutocorrect: false,
          leadingIcon: const Icon(LucideIcons.search),
          trailingIcon: _buildTrailingIcon(
            searchState: searchState,
            onClearPressed: onClearPressed,
            context: context,
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          isDisabled: isDisabled,
          contentPadding: const EdgeInsets.symmetric(
            vertical: LmuSizes.small,
          ),
        );

  static Widget _buildTrailingIcon({
    required SearchState searchState,
    VoidCallback? onClearPressed,
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
      child: _getTrailingIconByState(searchState, onClearPressed, context),
    );
  }

  static Widget _getTrailingIconByState(
    SearchState state,
    VoidCallback? onClearPressed,
    BuildContext context,
  ) {
    switch (state) {
      case SearchState.base:
      case SearchState.active:
        return const SizedBox.shrink();
      case SearchState.typing:
        return IconButton(
          key: const ValueKey('typing'),
          icon: const Icon(LucideIcons.x),
          onPressed: onClearPressed,
          color: context.colors.neutralColors.textColors.weakColors.base,
        );
      case SearchState.filled:
        return IconButton(
          key: const ValueKey('filled'),
          icon: const Icon(LucideIcons.x),
          onPressed: onClearPressed,
          color: context.colors.neutralColors.textColors.strongColors.base,
        );
      case SearchState.loading:
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
