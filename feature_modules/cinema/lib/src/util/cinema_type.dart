import 'package:core/themes.dart';
import 'package:flutter/cupertino.dart';

enum CinemaType {
  lmu,
  tum,
  hm,
}

extension CinemaTypeTextExtension on CinemaType {
  String getValue() {
    switch (this) {
      case CinemaType.lmu:
        return 'LMU';
      case CinemaType.tum:
        return 'TUM';
      case CinemaType.hm:
        return 'HM';
    }
  }
}

extension CinemaTypeTextColorExtension on CinemaType {
  Color getTextColor(BuildContext context) {
    switch (this) {
      case CinemaType.lmu:
        return context.colors.universityColors.textColors.lmuColor;
      case CinemaType.tum:
        return context.colors.universityColors.textColors.tumColor;
      case CinemaType.hm:
        return context.colors.universityColors.textColors.hmColor;
    }
  }
}

extension CinemaBackgroundColorExtension on CinemaType {
  Color getBackgroundColor(BuildContext context) {
    switch (this) {
      case CinemaType.lmu:
        return context.colors.universityColors.backgroundColors.lmuColor;
      case CinemaType.tum:
        return context.colors.universityColors.backgroundColors.tumColor;
      case CinemaType.hm:
        return context.colors.universityColors.backgroundColors.hmColor;
    }
  }
}

extension CinemaTypeMapper on CinemaType {
  static CinemaType fromString(String type) {
    switch (type) {
      case "LMU":
        return CinemaType.lmu;
      case "TUM":
      case "TUM_GARCHING":
        return CinemaType.tum;
      case "HM":
        return CinemaType.hm;
      default:
        throw ArgumentError("Invalid status: $type");
    }
  }
}
