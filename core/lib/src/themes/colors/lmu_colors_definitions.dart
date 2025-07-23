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
        base: ColorPrimitives.green90,
        pressed: ColorPrimitives.green100,
        active: ColorPrimitives.green90,
        disabled: ColorPrimitives.trspGreen40,
      ),
    ),
  ),
  dangerColors: DangerColors(
    textColors: DangerTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.red70,
        pressed: ColorPrimitives.red80,
        active: ColorPrimitives.red70,
        disabled: ColorPrimitives.trspRed40,
      ),
    ),
    backgroundColors: DangerBackgroundColors(
      weakColors: WeakColors(
        base: ColorPrimitives.trspRed20,
        pressed: ColorPrimitives.trspRed30,
        active: ColorPrimitives.trspRed40,
        disabled: ColorPrimitives.trspRed20,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.red30,
        pressed: ColorPrimitives.red40,
        active: ColorPrimitives.red30,
        disabled: ColorPrimitives.trspRed20,
      ),
    ),
  ),
  warningColors: WarningColors(
    textColors: WarningTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.amber70,
        pressed: ColorPrimitives.amber80,
        active: ColorPrimitives.amber70,
        disabled: ColorPrimitives.trspAmber40,
      ),
    ),
  ),
  customColors: CustomColors(
    textColors: CustomTextColors(
      green: ColorPrimitives.green70,
      pink: ColorPrimitives.pink70,
      amber: ColorPrimitives.amber70,
      red: ColorPrimitives.red70,
      blue: ColorPrimitives.blue70,
      purple: ColorPrimitives.purple70,
      teal: ColorPrimitives.teal70,
      lime: ColorPrimitives.lime70,
      stuLounge: Color(0xFFF3BE79),
    ),
    backgroundColors: CustomBackgroundColors(
      green: ColorPrimitives.trspGreen20,
      pink: ColorPrimitives.trspPink20,
      amber: ColorPrimitives.trspAmber20,
      red: ColorPrimitives.trspRed20,
      blue: ColorPrimitives.trspBlue20,
      purple: ColorPrimitives.trspPurple20,
      teal: ColorPrimitives.trspTeal20,
      lime: ColorPrimitives.trspLime20,
      stuLounge: Color(0x2EB08B5D),
    ),
    colorColors: CustomColorColors(
      green: ColorPrimitives.green60,
      pink: ColorPrimitives.pink60,
      amber: ColorPrimitives.amber60,
      red: ColorPrimitives.red60,
      blue: ColorPrimitives.blue60,
      purple: ColorPrimitives.purple60,
      teal: ColorPrimitives.teal60,
      lime: ColorPrimitives.lime60,
      stuLounge: Color(0xFFF3BE79),
    ),
  ),
  brandColors: BrandColors(
    textColors: BrandTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.green70,
        pressed: ColorPrimitives.green80,
        active: ColorPrimitives.green70,
        disabled: ColorPrimitives.trspGreen40,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.green80,
        pressed: ColorPrimitives.green60,
        active: ColorPrimitives.green50,
        disabled: ColorPrimitives.trspGreen40,
      ),
    ),
    backgroundColors: BrandBackgroundColors(
      mediumColors: MediumColors(
        base: ColorPrimitives.green20,
        pressed: ColorPrimitives.green30,
        active: ColorPrimitives.green20,
        disabled: ColorPrimitives.trspGreen20,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.green50,
        pressed: ColorPrimitives.green60,
        active: ColorPrimitives.green50,
        disabled: ColorPrimitives.trspGreen20,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.green40,
        pressed: ColorPrimitives.green50,
        active: ColorPrimitives.green40,
        disabled: ColorPrimitives.trspGreen20,
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
              base: ColorPrimitives.green40,
              pressed: ColorPrimitives.green30,
              active: ColorPrimitives.green40,
              disabled: ColorPrimitives.trspGreen40))),
  dangerColors: DangerColors(
      textColors: DangerTextColors(
          strongColors: StrongColors(
              base: ColorPrimitives.red40,
              pressed: ColorPrimitives.red30,
              active: ColorPrimitives.red40,
              disabled: ColorPrimitives.trspRed40)),
      backgroundColors: DangerBackgroundColors(
          weakColors: WeakColors(
              base: ColorPrimitives.red90,
              pressed: ColorPrimitives.red80,
              active: ColorPrimitives.red90,
              disabled: ColorPrimitives.trspRed10),
          strongColors: StrongColors(
              base: ColorPrimitives.red30,
              pressed: ColorPrimitives.red20,
              active: ColorPrimitives.red30,
              disabled: ColorPrimitives.trspRed20))),
  warningColors: WarningColors(
      textColors: WarningTextColors(
          strongColors: StrongColors(
              base: ColorPrimitives.amber50,
              pressed: ColorPrimitives.amber40,
              active: ColorPrimitives.amber50,
              disabled: ColorPrimitives.trspAmber40))),
  customColors: CustomColors(
    textColors: CustomTextColors(
      green: ColorPrimitives.green40,
      pink: ColorPrimitives.pink40,
      amber: ColorPrimitives.amber40,
      red: ColorPrimitives.red40,
      blue: ColorPrimitives.blue40,
      purple: ColorPrimitives.purple40,
      teal: ColorPrimitives.teal40,
      lime: ColorPrimitives.lime40,
      stuLounge: Color(0xFF745936),
    ),
    backgroundColors: CustomBackgroundColors(
      green: ColorPrimitives.trspGreen20,
      pink: ColorPrimitives.trspPink20,
      amber: ColorPrimitives.trspAmber20,
      red: ColorPrimitives.trspRed20,
      blue: ColorPrimitives.trspBlue20,
      purple: ColorPrimitives.trspPurple20,
      teal: ColorPrimitives.trspTeal20,
      lime: ColorPrimitives.trspLime20,
      stuLounge: Color(0x2E977243),
    ),
    colorColors: CustomColorColors(
      green: ColorPrimitives.green40,
      pink: ColorPrimitives.pink40,
      amber: ColorPrimitives.amber40,
      red: ColorPrimitives.red40,
      blue: ColorPrimitives.blue40,
      purple: ColorPrimitives.purple40,
      teal: ColorPrimitives.teal40,
      lime: ColorPrimitives.lime40,
      stuLounge: Color.fromARGB(255, 167, 126, 72),
    ),
  ),
  brandColors: BrandColors(
    textColors: BrandTextColors(
      strongColors: StrongColors(
        base: ColorPrimitives.green40,
        pressed: ColorPrimitives.green30,
        active: ColorPrimitives.green40,
        disabled: ColorPrimitives.trspGreen40,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.green50,
        pressed: ColorPrimitives.green40,
        active: ColorPrimitives.green50,
        disabled: ColorPrimitives.trspGreen40,
      ),
    ),
    backgroundColors: BrandBackgroundColors(
      mediumColors: MediumColors(
        base: ColorPrimitives.green100,
        pressed: ColorPrimitives.green90,
        active: ColorPrimitives.green100,
        disabled: ColorPrimitives.trspGreen40,
      ),
      strongColors: StrongColors(
        base: ColorPrimitives.green60,
        pressed: ColorPrimitives.green50,
        active: ColorPrimitives.green60,
        disabled: ColorPrimitives.trspGreen40,
      ),
      nonInvertableColors: NonInvertableColors(
        base: ColorPrimitives.green40,
        pressed: ColorPrimitives.green30,
        active: ColorPrimitives.green40,
        disabled: ColorPrimitives.trspGreen40,
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
