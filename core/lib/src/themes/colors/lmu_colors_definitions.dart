import 'package:core/src/themes/colors/brand_colors.dart';
import 'package:flutter/material.dart';

import 'color_construct.dart';
import 'color_primitives.dart';
import 'lmu_colors_theme_extension.dart';
import 'mensa_colors.dart';
import 'neutral_colors.dart';

const lmuColorsDark = LmuColors(
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
          active: ColorPrimitives.trspWhite95),
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
        base: ColorPrimitives.trspWhite20,
        pressed: ColorPrimitives.trspWhite30,
        active: ColorPrimitives.trspWhite40,
        disabled: ColorPrimitives.trspWhite10,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.trspWhite20,
        pressed: ColorPrimitives.trspWhite95,
        disabled: ColorPrimitives.grey30,
        active: ColorPrimitives.trspWhite95,
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
  mensaColors: MensaColors(
    textColors: MensaTextColors(
      mensa: Color(0xFF75DB70),
      stuBistro: Color(0xFFDD3C75),
      stuCafe: Color(0xFFF3941A),
      stuLounge: Color(0xFFF3BE79),
    ),
    backgroundColors: MensaBackgroundColors(
      mensa: Color(0x1F47EA3F),
      stuBistro: Color(0x29F40B5D),
      stuCafe: Color(0x26F18801),
      stuLounge: Color(0x2EB08B5D),
    ),
  ),
  brandColors: BrandColors(
    textColors: BrandTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.brand70,
        pressed: ColorPrimitives.brand80,
        active: ColorPrimitives.brand80,
        disabled: ColorPrimitives.brand100,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.brand80,
        pressed: ColorPrimitives.brand60,
        disabled: ColorPrimitives.brand30,
        active: ColorPrimitives.brand50,
      ),
    ),
    backgroundColors: BrandBackgroundColors(
      mediumColors: MediumColors(
        base: ColorPrimitives.brand20,
        pressed: ColorPrimitives.brand10,
        active: ColorPrimitives.brand30,
        disabled: ColorPrimitives.brand10,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.brand80,
        pressed: ColorPrimitives.brand70,
        active: ColorPrimitives.brand60,
        disabled: ColorPrimitives.brand10,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.brand80,
        pressed: ColorPrimitives.brand70,
        disabled: ColorPrimitives.brand10,
        active: ColorPrimitives.brand50,
      ),
    ),
  ),
);

const lmuColorsLight = LmuColors(
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
        disabled: ColorPrimitives.trspWhite50,
        active: ColorPrimitives.trspWhite95,
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
        base: ColorPrimitives.trspBlack20,
        pressed: ColorPrimitives.trspBlack30,
        active: ColorPrimitives.trspBlack40,
        disabled: ColorPrimitives.trspBlack10,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.trspWhite20,
        pressed: ColorPrimitives.trspWhite95,
        disabled: ColorPrimitives.grey30,
        active: ColorPrimitives.trspWhite95,
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
  mensaColors: MensaColors(
    textColors: MensaTextColors(
      mensa: Color(0xFF4FBF4A),
      stuBistro: Color(0xFFD83972),
      stuCafe: Color(0xFFE78201),
      stuLounge: Color(0xFF745936),
    ),
    backgroundColors: MensaBackgroundColors(
      mensa: Color(0x261CB814),
      stuBistro: Color(0x26F40B5D),
      stuCafe: Color(0x30FF9001),
      stuLounge: Color(0x2E977243),
    ),
  ),
  brandColors: BrandColors(
    textColors: BrandTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.brand70,
        pressed: ColorPrimitives.brand80,
        active: ColorPrimitives.brand80,
        disabled: ColorPrimitives.brand110,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.brand80,
        pressed: ColorPrimitives.brand60,
        disabled: ColorPrimitives.brand30,
        active: ColorPrimitives.brand50,
      ),
    ),
    backgroundColors: BrandBackgroundColors(
      mediumColors: MediumColors(
        base: ColorPrimitives.brand130,
        pressed: ColorPrimitives.brand120,
        active: ColorPrimitives.brand110,
        disabled: ColorPrimitives.brand140,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.brand70,
        pressed: ColorPrimitives.brand60,
        active: ColorPrimitives.brand60,
        disabled: ColorPrimitives.brand120,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.brand70,
        pressed: ColorPrimitives.brand60,
        disabled: ColorPrimitives.brand10,
        active: ColorPrimitives.brand50,
      ),
    ),
  ),
);
