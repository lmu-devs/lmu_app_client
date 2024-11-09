part of 'lmu_button.dart';

enum ButtonColors {
  brandBgNonInvBase,
  brandBgStrongDisabled,
  neutralTextNonInvBase,
  neutralTextNonInvDisabled,
  neutralBgFlippedBase,
  neutralBgFlippedDisabled,
  neutralTextFlippedBase,
  neutralTextFlippedDisabled,
  dangerBgStrongBase,
  dangerBgStrongDisabled,
  neutralBgMediumBase,
  neutralBgMediumDisabled,
  neutralTextStrongBase,
  neutralTextWeakDisabled,
  neutralTextWeakBase,
  brandTextStrongBase,
  brandTextStrongDisabled,
  dangerTextStrongBase,
  dangerTextStrongDisabled,
  neutralTextStrongDisabled,
  noColor,
}

// Map according to figma design system
final Map<Tuple3<ButtonAction, ButtonEmphasis, ButtonState>, Tuple2<ButtonColors, ButtonColors>> _colorMap = {
  //Primary Button
  const Tuple3(ButtonAction.base, ButtonEmphasis.primary, ButtonState.enabled):
      const Tuple2(ButtonColors.brandBgNonInvBase, ButtonColors.neutralTextNonInvBase),
  const Tuple3(ButtonAction.contrast, ButtonEmphasis.primary, ButtonState.enabled):
      const Tuple2(ButtonColors.neutralBgFlippedBase, ButtonColors.neutralTextFlippedBase),
  const Tuple3(ButtonAction.destructive, ButtonEmphasis.primary, ButtonState.enabled):
      const Tuple2(ButtonColors.dangerBgStrongBase, ButtonColors.neutralTextNonInvBase),
  const Tuple3(ButtonAction.base, ButtonEmphasis.primary, ButtonState.disabled):
      const Tuple2(ButtonColors.brandBgStrongDisabled, ButtonColors.neutralTextNonInvDisabled),
  const Tuple3(ButtonAction.contrast, ButtonEmphasis.primary, ButtonState.disabled):
      const Tuple2(ButtonColors.neutralBgFlippedDisabled, ButtonColors.neutralTextFlippedDisabled),
  const Tuple3(ButtonAction.destructive, ButtonEmphasis.primary, ButtonState.disabled):
      const Tuple2(ButtonColors.dangerBgStrongDisabled, ButtonColors.neutralTextNonInvDisabled),

  //Secondary Button
  const Tuple3(ButtonAction.base, ButtonEmphasis.secondary, ButtonState.enabled):
      const Tuple2(ButtonColors.neutralBgMediumBase, ButtonColors.neutralTextStrongBase),
  const Tuple3(ButtonAction.base, ButtonEmphasis.secondary, ButtonState.disabled):
      const Tuple2(ButtonColors.neutralBgMediumDisabled, ButtonColors.neutralTextWeakDisabled),

  //Tertiary Button
  const Tuple3(ButtonAction.base, ButtonEmphasis.tertiary, ButtonState.enabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.neutralTextWeakBase),
  const Tuple3(ButtonAction.base, ButtonEmphasis.tertiary, ButtonState.disabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.neutralTextWeakDisabled),

  //Outline Button
  const Tuple3(ButtonAction.base, ButtonEmphasis.outline, ButtonState.enabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.brandTextStrongBase),
  const Tuple3(ButtonAction.contrast, ButtonEmphasis.outline, ButtonState.enabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.neutralTextStrongBase),
  const Tuple3(ButtonAction.destructive, ButtonEmphasis.outline, ButtonState.enabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.dangerTextStrongBase),
  const Tuple3(ButtonAction.base, ButtonEmphasis.outline, ButtonState.disabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.brandTextStrongDisabled),
  const Tuple3(ButtonAction.contrast, ButtonEmphasis.outline, ButtonState.disabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.neutralTextStrongDisabled),
  const Tuple3(ButtonAction.destructive, ButtonEmphasis.outline, ButtonState.disabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.dangerTextStrongDisabled),

  //Link Button
  const Tuple3(ButtonAction.base, ButtonEmphasis.link, ButtonState.enabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.brandTextStrongBase),
  const Tuple3(ButtonAction.contrast, ButtonEmphasis.link, ButtonState.enabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.neutralTextStrongBase),
  const Tuple3(ButtonAction.destructive, ButtonEmphasis.link, ButtonState.enabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.dangerTextStrongBase),
  const Tuple3(ButtonAction.base, ButtonEmphasis.link, ButtonState.disabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.brandTextStrongDisabled),
  const Tuple3(ButtonAction.contrast, ButtonEmphasis.link, ButtonState.disabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.neutralTextStrongDisabled),
  const Tuple3(ButtonAction.destructive, ButtonEmphasis.link, ButtonState.disabled):
      const Tuple2(ButtonColors.noColor, ButtonColors.dangerTextStrongDisabled),
};

extension ButtonColorMapper on ButtonColors {
  Color color(LmuColors colors) {
    switch (this) {
      case ButtonColors.brandBgNonInvBase:
        return colors.brandColors.backgroundColors.nonInvertableColors.base;
      case ButtonColors.brandBgStrongDisabled:
        return colors.brandColors.backgroundColors.strongColors.disabled!;
      case ButtonColors.neutralTextNonInvBase:
        return colors.neutralColors.textColors.nonInvertableColors.base;
      case ButtonColors.neutralTextNonInvDisabled:
        return colors.neutralColors.textColors.nonInvertableColors.disabled!;
      case ButtonColors.neutralBgFlippedBase:
        return colors.neutralColors.backgroundColors.flippedColors.base;
      case ButtonColors.neutralBgFlippedDisabled:
        return colors.neutralColors.backgroundColors.flippedColors.disabled!;
      case ButtonColors.neutralTextFlippedBase:
        return colors.neutralColors.textColors.flippedColors.base;
      case ButtonColors.neutralTextFlippedDisabled:
        return colors.neutralColors.textColors.flippedColors.disabled!;
      case ButtonColors.dangerBgStrongBase:
        return colors.dangerColors.backgroundColors.strongColors.base;
      case ButtonColors.dangerBgStrongDisabled:
        return colors.dangerColors.backgroundColors.strongColors.disabled!;
      case ButtonColors.neutralBgMediumBase:
        return colors.neutralColors.backgroundColors.mediumColors.base;
      case ButtonColors.neutralBgMediumDisabled:
        return colors.neutralColors.backgroundColors.mediumColors.disabled!;
      case ButtonColors.neutralTextStrongBase:
        return colors.neutralColors.textColors.strongColors.base;
      case ButtonColors.neutralTextWeakDisabled:
        return colors.neutralColors.textColors.weakColors.disabled!;
      case ButtonColors.neutralTextWeakBase:
        return colors.neutralColors.textColors.weakColors.base;
      case ButtonColors.brandTextStrongBase:
        return colors.brandColors.textColors.strongColors.base;
      case ButtonColors.brandTextStrongDisabled:
        return colors.brandColors.textColors.strongColors.disabled!;
      case ButtonColors.dangerTextStrongBase:
        return colors.dangerColors.textColors.strongColors.base;
      case ButtonColors.dangerTextStrongDisabled:
        return colors.dangerColors.textColors.strongColors.disabled!;
      case ButtonColors.neutralTextStrongDisabled:
        return colors.neutralColors.textColors.strongColors.disabled!;
      case ButtonColors.noColor:
        return Colors.transparent;
    }
  }
}

Tuple2<ButtonColors, ButtonColors> _getButtonColors(ButtonAction action, ButtonEmphasis emphasis, ButtonState state) {
  // If the button is loading, we want to show the enabled state colors
  if (state == ButtonState.loading) {
    state = ButtonState.enabled;
  }

  final buttonConfig = Tuple3(action, emphasis, state);
  final hasMappedColors = _colorMap.containsKey(buttonConfig);
  if (!hasMappedColors) {
    throw Exception('No colors mapped for ButtonAction: $action, ButtonEmphasis: $emphasis, ButtonState: $state');
  }

  return _colorMap[buttonConfig]!;
}
