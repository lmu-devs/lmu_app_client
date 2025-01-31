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

extension CinemaTypeColorExtension on CinemaType {
  Color getColor(BuildContext context) {
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
