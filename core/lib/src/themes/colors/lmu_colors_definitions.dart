import 'package:flutter/material.dart';

import 'brand_colors.dart';
import 'color_construct.dart';
import 'color_primitives.dart';
import 'custom_colors.dart';
import 'danger_colors.dart';
import 'gradient_colors.dart';
import 'lmu_colors_theme_extension.dart';
import 'neutral_colors.dart';
import 'success_colors.dart';
import 'university_colors.dart';
import 'warning_colors.dart';

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
        active: ColorPrimitives.trspWhite95,
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
        base: ColorPrimitives.trspWhite07,
        pressed: ColorPrimitives.trspWhite10,
        active: ColorPrimitives.trspWhite20,
        disabled: ColorPrimitives.trspWhite07,
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
      inputStroke: ColorPrimitives.trspWhite07,
      cutout: ColorPrimitives.black,
      seperatorDark: ColorPrimitives.black,
      iconOutline: ColorPrimitives.trspBlack80,
      tile: ColorPrimitives.trspBlack00,
    ),
  ),
  successColors: SuccessColors(
    textColors: SuccessTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.brand100,
        pressed: ColorPrimitives.brand120,
        active: ColorPrimitives.brand100,
        disabled: ColorPrimitives.brand30,
      ),
    ),
  ),
  dangerColors: DangerColors(
    textColors: DangerTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.red70,
        pressed: ColorPrimitives.red50,
        active: ColorPrimitives.red70,
        disabled: ColorPrimitives.red30,
      ),
    ),
    backgroundColors: DangerBackgroundColors(
      weakColors: WeakColors(
        base: ColorPrimitives.red20,
        pressed: ColorPrimitives.red30,
        active: ColorPrimitives.red20,
        disabled: ColorPrimitives.red10,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.red50,
        pressed: ColorPrimitives.red40,
        active: ColorPrimitives.red50,
        disabled: ColorPrimitives.red20,
      ),
    ),
  ),
  warningColors: WarningColors(
    textColors: WarningTextColors(
      strongColors: StrongColors(
          base: ColorPrimitives.amber70,
          pressed: ColorPrimitives.amber50,
          active: ColorPrimitives.amber70,
          disabled: ColorPrimitives.amber30),
    ),
  ),
  customColors: CustomColors(
    textColors: CustomTextColors(
      mensa: Color(0xFF75DB70),
      stuBistro: Color(0xFFE75589),
      stuCafe: Color(0xFFF3941A),
      stuLounge: Color(0xFFF3BE79),
      cinema: Color(0xFFDE4242),
      building: Color(0xFF1C94F0),
      library: Color(0xFFB75AF1),
    ),
    backgroundColors: CustomBackgroundColors(
      mensa: Color(0x1F47EA3F),
      stuBistro: Color(0x29F40B5D),
      stuCafe: Color(0x26F18801),
      stuLounge: Color(0x2EB08B5D),
      cinema: Color(0x24DE4242),
      building: Color(0x2E1C94F0),
      library: Color(0x29B75AF1),
    ),
  ),
  brandColors: BrandColors(
    textColors: BrandTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.brand80,
        pressed: ColorPrimitives.brand70,
        active: ColorPrimitives.brand70,
        disabled: ColorPrimitives.trspWhite30,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.brand80,
        pressed: ColorPrimitives.brand60,
        active: ColorPrimitives.brand50,
        disabled: ColorPrimitives.trspWhite30,
      ),
    ),
    backgroundColors: BrandBackgroundColors(
      mediumColors: MediumColors(
        base: ColorPrimitives.brand30,
        pressed: ColorPrimitives.brand40,
        active: ColorPrimitives.brand40,
        disabled: ColorPrimitives.brand30,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.brand80,
        pressed: ColorPrimitives.brand70,
        active: ColorPrimitives.brand60,
        disabled: ColorPrimitives.brand30,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.brand70,
        pressed: ColorPrimitives.brand60,
        active: ColorPrimitives.brand70,
        disabled: ColorPrimitives.brand10,
      ),
    ),
  ),
  gradientColors: GradientColors(
    gradientLoadingColors: GradientLoadingColors(
      base: ColorPrimitives.trspWhite10,
      highlight: ColorPrimitives.trspWhite07,
    ),
    gradientFadeColors: GradientFadeColors(
      start: Color(0x001f1f21),
      end: ColorPrimitives.grey20,
    ),
  ),
  universityColors: UniversityColors(
    textColors: UniversityTextColors(
      lmuColor: Color(0xFF26D16F),
      tumColor: Color(0xFF5E9CE5),
      hmColor: Color(0xFFFC696A),
    ),
    backgroundColors: UniversityBackgroundColors(
      lmuColor: Color(0x2426D16F),
      tumColor: Color(0x295E9CE5),
      hmColor: Color(0x24FC696A),
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
        base: ColorPrimitives.trspBlack05,
        pressed: ColorPrimitives.trspBlack10,
        active: ColorPrimitives.trspBlack20,
        disabled: ColorPrimitives.trspBlack05,
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
      iconOutline: ColorPrimitives.trspWhite95,
      tile: ColorPrimitives.white,
    ),
  ),
  successColors: SuccessColors(
      textColors: SuccessTextColors(
          strongColors: StrongColors(
              base: ColorPrimitives.brand70,
              pressed: ColorPrimitives.brand50,
              active: ColorPrimitives.brand70,
              disabled: ColorPrimitives.brand110))),
  dangerColors: DangerColors(
      textColors: DangerTextColors(
          strongColors: StrongColors(
              base: ColorPrimitives.red70,
              pressed: ColorPrimitives.red50,
              active: ColorPrimitives.red70,
              disabled: ColorPrimitives.red30)),
      backgroundColors: DangerBackgroundColors(
          weakColors: WeakColors(
              base: ColorPrimitives.red100,
              pressed: ColorPrimitives.red90,
              active: ColorPrimitives.red80,
              disabled: ColorPrimitives.red100),
          strongColors: StrongColors(
              base: ColorPrimitives.red50,
              pressed: ColorPrimitives.red40,
              active: ColorPrimitives.red50,
              disabled: ColorPrimitives.red20))),
  warningColors: WarningColors(
      textColors: WarningTextColors(
          strongColors: StrongColors(
              base: ColorPrimitives.amber60,
              pressed: ColorPrimitives.amber60,
              active: ColorPrimitives.amber60,
              disabled: ColorPrimitives.amber60))),
  customColors: CustomColors(
    textColors: CustomTextColors(
      mensa: Color(0xFF4FBF4A),
      stuBistro: Color(0xFFD83972),
      stuCafe: Color(0xFFE78201),
      stuLounge: Color(0xFF745936),
      cinema: Color(0xFFEA4A4A),
      building: Color(0xFF39A6F9),
      library: Color(0xFFBE67F4),
    ),
    backgroundColors: CustomBackgroundColors(
      mensa: Color(0x261CB814),
      stuBistro: Color(0x26F40B5D),
      stuCafe: Color(0x30FF9001),
      stuLounge: Color(0x2E977243),
      cinema: Color(0x29EA4A4A),
      building: Color(0x2139A6F9),
      library: Color(0x24BE67F4),
    ),
  ),
  brandColors: BrandColors(
    textColors: BrandTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.brand60,
        pressed: ColorPrimitives.brand80,
        active: ColorPrimitives.brand60,
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
        base: ColorPrimitives.brand60,
        pressed: ColorPrimitives.brand50,
        active: ColorPrimitives.brand60,
        disabled: ColorPrimitives.brand10,
      ),
    ),
  ),
  gradientColors: GradientColors(
    gradientLoadingColors: GradientLoadingColors(
      base: ColorPrimitives.trspBlack10,
      highlight: ColorPrimitives.trspBlack05,
    ),
    gradientFadeColors: GradientFadeColors(
      start: ColorPrimitives.trspWhite00,
      end: ColorPrimitives.white,
    ),
  ),
  universityColors: UniversityColors(
    textColors: UniversityTextColors(
      lmuColor: Color(0xFF00883A),
      tumColor: Color(0xFF14519A),
      hmColor: Color(0xFFFA3839),
    ),
    backgroundColors: UniversityBackgroundColors(
      lmuColor: Color(0x2400883A),
      tumColor: Color(0x2614519A),
      hmColor: Color(0x2BFA3839),
    ),
  ),
);
