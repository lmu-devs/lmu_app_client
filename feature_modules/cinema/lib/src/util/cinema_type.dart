import 'dart:ui';

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
  Color getColor() {
    switch (this) {
      case CinemaType.lmu:
        return const Color(0xFF00883A);
      case CinemaType.tum:
      case CinemaType.tumGarching:
        return const Color(0xFF14519A);
      case CinemaType.hm:
        return const Color(0xFFFA3839);
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
