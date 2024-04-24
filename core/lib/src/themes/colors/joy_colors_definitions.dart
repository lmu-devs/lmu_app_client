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
        disabled: ColorPrimitives.trspBlack30,
      ),
      mediumColors: MediumColors(
        base: ColorPrimitives.trspBlack67,
        pressed: ColorPrimitives.trspBlack60,
        disabled: ColorPrimitives.trspBlack30,
      ),
      weakColors: WeakColors(
        base: ColorPrimitives.trspBlack40,
        pressed: ColorPrimitives.trspBlack50,
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
      base: Colors.black,
      tile: Colors.black,
      pure: Colors.black,
      weakColors: WeakColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
      mediumColors: MediumColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
      strongColors: StrongColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
      nonInvertableColors: NonInvertableColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
        decoration: Colors.black,
      ),
      flippedColors: FlippedColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
    ),
    borderColors: BorderColors(
      seperatorLight: Colors.black,
      inputStroke: Colors.black,
      cutout: Colors.black,
      seperatorDark: Colors.black,
    ),
  ),
);

const joyColorsDark = JoyColors(
  neutralColors: NeutralColors(
    textColors: TextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.trspWhite95,
        pressed: ColorPrimitives.trspWhite82,
        disabled: ColorPrimitives.trspWhite30,
      ),
      mediumColors: MediumColors(
        base: ColorPrimitives.trspWhite65,
        pressed: ColorPrimitives.trspWhite58,
        disabled: ColorPrimitives.trspWhite30,
      ),
      weakColors: WeakColors(
        base: ColorPrimitives.trspWhite40,
        pressed: ColorPrimitives.trspWhite50,
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
      base: Colors.white,
      tile: Colors.black,
      pure: Colors.black,
      weakColors: WeakColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
      mediumColors: MediumColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
      strongColors: StrongColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
      nonInvertableColors: NonInvertableColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
        decoration: Colors.black,
      ),
      flippedColors: FlippedColors(
        base: Colors.black,
        pressed: Colors.black,
        disabled: Colors.black,
      ),
    ),
    borderColors: BorderColors(
      seperatorLight: Colors.black,
      inputStroke: Colors.black,
      cutout: Colors.black,
      seperatorDark: Colors.black,
    ),
  ),
);
