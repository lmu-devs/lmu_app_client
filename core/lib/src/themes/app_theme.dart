import 'package:core/src/constants/spacing_atoms.dart';
import 'package:core/src/themes/models/neutral_colors.dart';
import 'package:flutter/material.dart';

import 'lmu_colors_theme_extension.dart';
import 'texts/text_themes.dart';

class AppTheme {
  static whatever = SpacingAtoms.gaps.tile;
  static ThemeData light = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      const TextColors(
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
    ),
    extensions: const <ThemeExtension<dynamic>>[
      LmuColors(
        brandColor: Color.fromARGB(255, 199, 93, 22),
        danger: Color(0xFFEF9A9A),
        neutralColors: NeutralColors(
          textColors: TextColors(
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
      ),
    ],
  );

  static ThemeData dark = ThemeData(
    textTheme: getBaseTextTheme(
      "Inter",
      const TextColors(
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
    ),
    extensions: const <ThemeExtension<dynamic>>[
      LmuColors(
        brandColor: Color.fromARGB(255, 199, 93, 22),
        danger: Color(0xFFEF9A9A),
        neutralColors: NeutralColors(
          textColors: TextColors(
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
      ),
    ],
  );
}
