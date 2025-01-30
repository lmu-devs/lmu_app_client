import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';

enum CinemaType {
  lmu,
  tum,
  tumGarching,
  hm,
}

extension CinemaTypeTextExtension on CinemaType {
  String getValue() {
    switch (this) {
      case CinemaType.lmu:
        return 'LMU';
      case CinemaType.tum:
        return 'TUM';
      case CinemaType.tumGarching:
        return 'TUM Garching';
      case CinemaType.hm:
        return 'HM';
    }
  }
}

extension CinemaTypeColorExtension on CinemaType {
  Color getColor(BuildContext context) {
    switch (this) {
      case CinemaType.lmu:
        return context.colors.universityColors.textColors.lmuColor;
      case CinemaType.tum:
      case CinemaType.tumGarching:
        return context.colors.universityColors.textColors.tumColor;
      case CinemaType.hm:
        return context.colors.universityColors.textColors.hmColor;
    }
  }
}

extension CinemaTypeMapper on CinemaType {
  static CinemaType fromString(String type) {
    switch (type) {
      case "LMU":
        return CinemaType.lmu;
      case "TUM":
        return CinemaType.tum;
      case "TUM_GARCHING":
        return CinemaType.tumGarching;
      case "HM":
        return CinemaType.hm;
      default:
        throw ArgumentError("Invalid status: $type");
    }
  }
}
