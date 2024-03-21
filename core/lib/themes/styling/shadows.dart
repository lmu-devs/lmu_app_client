import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../components/definitions.dart';
import './shadows_styles.dart';

enum ShadowType { levitated, indented }

class Shadows {
  static List<BoxShadow> getShadow({
    required Brightness mode,
    required ElementType type,
    required ShadowType shadowType,
  }) {
    switch (mode) {
      case Brightness.dark:
        switch (type) {
          case ElementType.primary:
            return shadowType == ShadowType.levitated
                ? [ShadowStyles.darkPrimaryLevitatedOutside, ShadowStyles.darkPrimaryLevitatedInside]
                : [
                    const BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 0.25),
                      blurRadius: 1,
                      offset: Offset(0, -1),
                      inset: true,
                    )
                  ];
          case ElementType.secondary:
            return shadowType == ShadowType.levitated
                ? [ShadowStyles.darkSecondaryLevitatedOutside, ShadowStyles.darkSecondaryLevitatedInside]
                : [
                    const BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.25), blurRadius: 1, offset: Offset(0, -1), inset: true)
                  ];
          default:
            return [];
        }
      case Brightness.light:
        switch (type) {
          case ElementType.primary:
            return shadowType == ShadowType.levitated
                ? [ShadowStyles.lightPrimaryLevitatedInside, ShadowStyles.lightPrimaryLevitatedInside2]
                : [
                    const BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.8), blurRadius: 1, offset: Offset(0, -1), inset: true)
                  ];
          case ElementType.secondary:
            return shadowType == ShadowType.levitated
                ? [ShadowStyles.lightSecondaryLevitatedOutside, ShadowStyles.lightSecondaryLevitatedInside]
                : [
                    const BoxShadow(
                        color: Color.fromRGBO(255, 255, 255, 0.8), blurRadius: 1, offset: Offset(0, -1), inset: true)
                  ];
          default:
            return [];
        }
    }
  }
}
