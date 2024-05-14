import 'package:flutter/material.dart';

import 'color_primitives.dart';
import 'joy_colors_theme_extension.dart';
import 'neutral_colors.dart';

const joyColorsLight = JoyColors(
  neutralColors: NeutralColors(
    textColors: TextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.trspBlack95,
        pressed: ColorPrimitives.trspBlack80,
        active: ColorPrimitives.trspBlack80,
        disabled: ColorPrimitives.trspBlack30,
      ),
      mediumColors: MediumColors(
        base: ColorPrimitives.trspBlack67,
        pressed: ColorPrimitives.trspBlack60,
        active: ColorPrimitives.trspBlack60,
        disabled: ColorPrimitives.trspBlack30,
      ),
      weakColors: WeakColors(
        base: ColorPrimitives.trspBlack40,
        pressed: ColorPrimitives.trspBlack50,
        active: ColorPrimitives.trspBlack50,
        disabled: ColorPrimitives.trspBlack30,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.white,
        pressed: ColorPrimitives.trspWhite95,
        disabled: Colors.white30,
        decoration: ColorPrimitives.grey80,
      ),
      flippedColors: FlippedColors(
        base: ColorPrimitives.trspWhite95,
        pressed: ColorPrimitives.trspWhite75,
        disabled: ColorPrimitives.trspWhite30,
      ),
    ),
    backgroundColors: BackgroundColors(
      base: ColorPrimitives.grey90,
      tile: ColorPrimitives.white,
      pure: ColorPrimitives.white,
      weakColors: WeakColors(
        base: ColorPrimitives.trspBlack00,
        pressed: ColorPrimitives.trspBlack05,
        active: ColorPrimitives.trspBlack10,
        disabled: ColorPrimitives.trspBlack00,
      ),
      mediumColors: MediumColors(
        base: ColorPrimitives.trspBlack10,
        pressed: ColorPrimitives.trspBlack20,
        active: ColorPrimitives.trspBlack30,
        disabled: ColorPrimitives.trspBlack10,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.grey100,
        pressed: ColorPrimitives.grey90,
        active: ColorPrimitives.grey80,
        disabled: ColorPrimitives.grey90,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.trspWhite20,
        pressed: ColorPrimitives.trspWhite95,
        disabled: ColorPrimitives.grey30,
        decoration: ColorPrimitives.grey40,
      ),
      flippedColors: FlippedColors(
        base: ColorPrimitives.trspBlack95,
        pressed: ColorPrimitives.trspBlack80,
        disabled: ColorPrimitives.trspBlack30,
      ),
    ),
    borderColors: BorderColors(
      seperatorLight: ColorPrimitives.trspBlack10,
      inputStroke: ColorPrimitives.trspBlack05,
      cutout: ColorPrimitives.white,
      seperatorDark: ColorPrimitives.white,
    ),
  ),
);

const joyColorsDark = JoyColors(
  neutralColors: NeutralColors(
    textColors: TextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.trspWhite95,
        pressed: ColorPrimitives.trspWhite82,
        active: ColorPrimitives.trspWhite82,
        disabled: ColorPrimitives.trspWhite30,
      ),
      mediumColors: MediumColors(
        base: ColorPrimitives.trspWhite65,
        pressed: ColorPrimitives.trspWhite58,
        active: ColorPrimitives.trspWhite58,
        disabled: ColorPrimitives.trspWhite30,
      ),
      weakColors: WeakColors(
        base: ColorPrimitives.trspWhite40,
        pressed: ColorPrimitives.trspWhite50,
        active: ColorPrimitives.trspWhite50,
        disabled: ColorPrimitives.trspWhite30,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.white,
        pressed: ColorPrimitives.trspWhite95,
        disabled: Colors.white30,
        decoration: ColorPrimitives.grey80,
      ),
      flippedColors: FlippedColors(
        base: ColorPrimitives.trspBlack90,
        pressed: ColorPrimitives.trspBlack67,
        disabled: ColorPrimitives.trspWhite30,
      ),
    ),
    backgroundColors: BackgroundColors(
      base: ColorPrimitives.grey10,
      tile: ColorPrimitives.grey20,
      pure: ColorPrimitives.black,
      weakColors: WeakColors(
        base: ColorPrimitives.trspWhite00,
        pressed: ColorPrimitives.trspWhite10,
        active: ColorPrimitives.trspWhite20,
        disabled: ColorPrimitives.trspWhite00,
      ),
      mediumColors: MediumColors(
        base: ColorPrimitives.trspWhite05,
        pressed: ColorPrimitives.trspWhite10,
        active: ColorPrimitives.trspWhite20,
        disabled: ColorPrimitives.trspWhite00,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.grey20,
        pressed: ColorPrimitives.grey30,
        active: ColorPrimitives.grey30,
        disabled: ColorPrimitives.grey10,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.trspWhite20,
        pressed: ColorPrimitives.trspWhite95,
        disabled: ColorPrimitives.grey30,
        decoration: ColorPrimitives.grey40,
      ),
      flippedColors: FlippedColors(
        base: ColorPrimitives.trspWhite95,
        pressed: ColorPrimitives.trspWhite82,
        disabled: ColorPrimitives.trspWhite30,
      ),
    ),
    borderColors: BorderColors(
      seperatorLight: ColorPrimitives.trspWhite10,
      inputStroke: ColorPrimitives.trspWhite05,
      cutout: ColorPrimitives.black,
      seperatorDark: ColorPrimitives.black,
    ),
  ),
);
